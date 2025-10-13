
# arsmagica_seasons_app/tests/integration_test.py


from django.test import TransactionTestCase, Client
from django.contrib.auth.models import User
from arsmagica_seasons_app.models import SeasonalWork
from arsmagica_seasons_app.gpthandler_class import GPTHandler
from django.urls import reverse


class SeasonalWorkGPTRealIntegrationTest(TransactionTestCase):
    
    """
    Full integration test using the real GPTHandler and real MySQL testdb.
    Verifies automatic and manual summary behavior end-to-end.
    """

    databases = {'testdb'}
    reset_sequences = False

    def setUp(self):
        
        self.username = "test_user_gpt_real"
        self.password = "secret123"
        self.email = "test_user_gpt_real@hotmail.com"
        self.client = Client()

        # Clean up old data first
        User.objects.using('testdb').filter(username = self.username).delete()

        # Create fresh test user
        self.user = User.objects.using('testdb').create_user(
            username = self.username,
            password = self.password,
            email = self.email
        )

        logged_in = self.client.login(username = self.username, password = self.password)
        self.assertTrue(logged_in, "Login failed for test user.")

        print(f"Logged in as {self.username}.")

    def test_auto_summary_generated_real_gpt(self):
        
        """
        When the summary is blank, the GPTHandler should contact OpenAI
        and store a real auto-generated summary.
        """

        create_url = reverse("seasonal_work_create")

        data = {
            "name": "Potion Research",
            "character_type": "Magi",
            "year": 1230,
            "season": "Winter",
            "summary": "",  # intentionally blank
            "description": (
                "Spent the entire season developing new magical potions for healing (CrCo 30) "
                "and resistance (ReIg 30) to cold environments. Conducted several lab experiments "
                "and documented results in detail. Gained 1 xp on Magic Theory."
            ),
        }

        response = self.client.post(create_url, data)
        self.assertEqual(response.status_code, 302, "Form did not redirect after GPT summarization.")

        # Retrieve created work
        work = SeasonalWork.objects.using('testdb').filter(user = self.user).first()
        self.assertIsNotNone(work, "Work not created in database.")

        print(f"Work created: {work.name}.")
        print(f"GPT Summary:\n'{work.summary}'")

        # Assert that GPTHandler actually filled the summary field
        self.assertTrue(len(work.summary.strip()) > 0, "GPT did not return a summary.")
        self.assertNotEqual(work.summary, "Auto-generated summary unavailable.", "Fallback summary used — GPT failed.")

        print("✅ GPTHandler successfully generated a real summary from OpenAI API.")

    def test_manual_summary_preserved_real(self):
        
        """
        When user provides their own summary, GPTHandler is bypassed.
        """

        create_url = reverse("seasonal_work_create")
        manual_summary = "Manual summary — written by the user."

        data = {
            "name": "Laboratory Assistance",
            "character_type": "Companion",
            "year": 1231,
            "season": "Spring",
            "summary": manual_summary,
            "description": (
                "Helped a Magus perform various alchemical procedures during the season. "
                "No experiments were performed independently."
            ),
        }

        response = self.client.post(create_url, data)
        self.assertEqual(response.status_code, 302, "Form did not redirect correctly.")

        work = SeasonalWork.objects.using('testdb').filter(user=self.user, name="Laboratory Assistance").first()
        self.assertIsNotNone(work, "Work not found in database after manual insert.")
        self.assertEqual(work.summary, manual_summary, "Manual summary was overwritten.")

        print("Manual summary preserved and GPT was not called.")

    def tearDown(self):
        
        SeasonalWork.objects.using('testdb').filter(user = self.user).delete()
        User.objects.using('testdb').filter(username = self.username).delete()
        print("Cleaned up test user and works.")
