
# arsmagica_seasons_app/tests/integration_test.py


from django.test import SimpleTestCase, Client
from django.contrib.auth.models import User
from arsmagica_seasons_app.models import SeasonalWork
from django.urls import reverse
from django.db import connections
from django.conf import settings


# Safety guard: never allow running on production server.

if not settings.DEBUG:

    raise RuntimeError("Refusing to run integration tests on production server.")


class SeasonalWorkGPTRealIntegrationTest(SimpleTestCase):
    
    """
    Full integration test using the real GPTHandler and real MySQL testdb.
    Verifies automatic and manual summary behavior end-to-end.
    """

    reset_sequences = False

    # ANSI color codes for terminal output.

    GREEN = "\033[92m"
    RED = "\033[91m"
    YELLOW = "\033[93m"
    BLUE = "\033[94m"
    RESET = "\033[0m"

    # Track passed test count.

    passed_tests = 0

    max_nr_of_tests = 3

    # To print text with different colors as class method.

    @classmethod
    def cprint(cls, message, color, fail = False):
        
        if not fail:
            
            print(f"{color}{message}{cls.RESET}")

        else:
            
            cls._class_fail(f"{color}{message}{cls.RESET}")

    def setUp(self):
        
        self.username = "test_user_gpt_real"
        self.password = "secret123"
        self.email = "test_user_gpt_real@hotmail.com"
        self.client = Client()

        # Clean up any leftover users or works.

        User.objects.using("testdb").filter(username = self.username).delete()
        User.objects.using("default").filter(username = self.username).delete()

        # Create user in both databases.

        self.user_default = User.objects.db_manager("default").create_user(
            username = self.username, 
            password = self.password, 
            email = self.email
        )

        self.user_testdb = User.objects.db_manager("testdb").create_user(
            username = self.username, 
            password = self.password, 
            email = self.email
        )

        logged_in = self.client.login(username = self.username, password = self.password)
        self.assertTrue(logged_in, "Login failed for test user.")

        self.cprint(f"\nLogged in as '{self.username}' on default DB.\n", self.BLUE)

    # Copies seasonal work for this 'test user' from the default database 
    # to the test database.

    def _sync_default_to_testdb(self):
           
        """Copy SeasonalWork rows for this user from default → testdb."""

        with connections["default"].cursor() as cursor_default, connections["testdb"].cursor() as cursor_test:
            
            cursor_default.execute(
                """
                SELECT * FROM arsmagica_seasons_app_seasonalwork
                WHERE user_id = (SELECT id FROM auth_user WHERE username = %s)
                """,
                [self.username],
            )
            rows = cursor_default.fetchall()
            if not rows:
                self.cprint(f"No works found in default DB.", self.YELLOW)
                return

            cursor_test.execute("SELECT id FROM auth_user WHERE username = %s", [self.username])
            user_row = cursor_test.fetchone()
            if not user_row:
                self.cprint(f"User not found in testdb!", self.RED)
                return
            test_user_id = user_row[0]

            cursor_test.execute(
                "DELETE FROM arsmagica_seasons_app_seasonalwork WHERE user_id = %s",
                [test_user_id],
            )

            columns = [col[0] for col in cursor_default.description]
            user_idx = columns.index("user_id")
            placeholders = ", ".join(["%s"] * len(columns))
            col_names = ", ".join(columns)
            insert_sql = f"INSERT INTO arsmagica_seasons_app_seasonalwork ({col_names}) VALUES ({placeholders})"

            for row in rows:
                row = list(row)
                row[user_idx] = test_user_id
                cursor_test.execute(insert_sql, row)

            print(f"{self.BLUE}[SYNC]:{self.RESET} Copied {len(rows)} SeasonalWork rows for '{self.username}' to testdb.\n")

    # Test 1 — GPT Auto Summary.

    def test_auto_summary_generated_real_gpt(self):
        
        self.cprint(f"Test 1: Auto Summary Generation ...", self.BLUE)

        create_url = reverse("seasonal_work_create")
        data = {
            "name": "Potion Research",
            "character_type": "Magi",
            "year": 1230,
            "season": "Winter",
            "summary": "",
            "description": (
                "Spent the entire season developing new magical potions for healing "
                "and resistance to cold environments. Conducted several lab experiments "
                "and documented results in detail. Gained 1 xp on Magic Theory."
            ),
        }

        response = self.client.post(create_url, data)
        self.assertEqual(response.status_code, 302, "Form did not redirect after GPT summarization.")

        self._sync_default_to_testdb()
        work = SeasonalWork.objects.using("testdb").filter(user = self.user_testdb).first()

        self.assertIsNotNone(work, "Work not created in database.")
        self.assertTrue(len(work.summary.strip()) > 0, "GPT did not return a summary.")
        self.assertNotEqual(work.summary, "Auto-generated summary unavailable.", "Fallback summary used — GPT failed.")

        print(f"Work created: '{work.name}'.")
        print(f"GPT Summary: '{work.summary}'.")
        self.cprint(f"✅ Test 1 ... OK\n", self.GREEN)

        SeasonalWorkGPTRealIntegrationTest.passed_tests += 1

    # Test 2 — Manual Summary.

    def test_manual_summary_preserved_real(self):
        
        self.cprint(f"Test 2: Manual Summary Preservation ...", self.BLUE)

        create_url = reverse("seasonal_work_create")
        manual_summary = "Manual summary — written by the user."

        data = {
            "name": "Laboratory Assistance",
            "character_type": "Companion",
            "year": 1231,
            "season": "Spring",
            "summary": manual_summary,
            "description": "Helped a Magus perform various alchemical procedures during the season.",
        }

        response = self.client.post(create_url, data)
        self.assertEqual(response.status_code, 302, "Form did not redirect correctly.")

        self._sync_default_to_testdb()

        work = SeasonalWork.objects.using("testdb").filter(user=self.user_testdb, name="Laboratory Assistance").first()
        self.assertIsNotNone(work, "Work not found in database after manual insert.")
        self.assertEqual(work.summary, manual_summary, "Manual summary was overwritten.")

        self.cprint(f"✅ Manual summary preserved correctly in testdb.", self.GREEN)
        self.cprint(f"✅ Test 2 ... OK\n", self.GREEN)

        SeasonalWorkGPTRealIntegrationTest.passed_tests += 1

    # Test 3 — No unauthorized usage.

    def test_other_user_cannot_edit_another_users_work(self):
        
        """
        Ensure that another logged-in user cannot edit or modify
        seasonal work belonging to someone else.
        """

        self.cprint(f"\nTest 3: Unauthorized Edit Attempt ...", self.BLUE)

        # Create one legitimate work entry for the main test user.

        work = SeasonalWork.objects.using("testdb").create(
            user = self.user_testdb,
            name = "Forbidden Experiment",
            character_type = "Magi",
            year = 1232,
            season = "Summer",
            summary = "Original summary by rightful owner.",
            description = "A secret lab experiment testing the limits of Vim vis."
        )

        # Create a new intruder user in both DBs.

        intruder_username = "test_user_intruder"
        intruder_password = "notallowed123"
        intruder_email = "intruder@hotmail.com"

        intruder_default = User.objects.db_manager("default").create_user(
            username = intruder_username,
            password = intruder_password,
            email = intruder_email
        )

        intruder_testdb = User.objects.db_manager("testdb").create_user(
            username = intruder_username,
            password = intruder_password,
            email = intruder_email
        )

        # Login as the intruder.

        logged_in = self.client.login(username = intruder_username, password = intruder_password)
        self.assertTrue(logged_in, "Login failed for intruder test user.")

        # Attempt to access the edit page for the original user's work.

        edit_url = reverse("update_seasonal_work", kwargs = {"pk": work.pk})
        response = self.client.get(edit_url)

        # Expected outcome: forbidden, redirected, or hidden (404).

        if response.status_code in (302, 403, 404):
            
            outcome = {
                302: "redirected (likely to login)",
                403: "forbidden",
                404: "hidden — object not visible to unauthorized users"
            }[response.status_code]

            self.cprint(f"✅ Unauthorized user blocked: {outcome}. (status: {response.status_code}).", self.GREEN)

            SeasonalWorkGPTRealIntegrationTest.passed_tests += 1

        else:
            
            self.cprint(f"❌ Unauthorized user gained access to edit page! (status: {response.status_code}).", self.RED, fail = True)

        self.cprint(f"✅ Test 3 ... OK\n", self.GREEN)

    # Override django's automatic cleanup process. 

    @classmethod
    def _cleanup_connections(cls):

        """
        Prevent Django from flushing our external databases after tests.
        """

        pass

    @classmethod
    def tearDownClass(cls):
        
        super().tearDownClass()

        # Clean up all SeasonalWork entries for test users, but keep the test accounts themselves.

        usernames_to_clean = ["test_user_gpt_real", "test_user_intruder"]

        for db_alias in ["default", "testdb"]:
           
           SeasonalWork.objects.using(db_alias).filter(user__username__in = usernames_to_clean).delete()

        # Final summary printed once after all tests.

        if cls.passed_tests ==  cls.max_nr_of_tests:
            
          cls.cprint(
            f"\n{cls.max_nr_of_tests} out of {cls.max_nr_of_tests} tests passed successfully!\n"
            f"✅ Test with a given summary worked.\n"
            f"✅ Test with an empty summary that was later filled by ChatGPT worked.\n"
            f"✅ Unauthorized user was correctly blocked from editing another user's work.\n",
            cls.GREEN
          )

        else:

          cls.cprint(
            f"❌ Some tests failed: {cls.passed_tests} out of {cls.max_nr_of_tests} passed.",
            cls.RED
          )
