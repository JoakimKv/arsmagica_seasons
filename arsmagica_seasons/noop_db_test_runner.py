
# noop_db_test_runner.py


from django.test.runner import DiscoverRunner


class NoDbOpsTestRunner(DiscoverRunner):

    """
    A safe test runner that NEVER creates, flushes, or destroys databases.
    Useful when pointing Django at live/external databases that must not be touched
    by the test framework's setup/teardown routines.

    Note: Tests must avoid Django TestCase/TransactionTestCase which expect isolated
    databases. Prefer SimpleTestCase and explicitly manage any test data.
    """

    def setup_databases(self, **kwargs):  # type: ignore[override]

        # Skip creating/cloning/serializing test databases entirely.
        return None

    def teardown_databases(self, old_config, **kwargs):  # type: ignore[override]

        # Skip tearing down or flushing any databases.
        return None

