
# utils/backup_utils.py


from django.contrib.auth.models import User
from django.contrib import messages
from ..models import SeasonalWork


def backup_seasonal_work_to_test(work):
    
    """
    Save a SeasonalWork instance into the 'test' database before deletion.
    """

    # Ensure user exists in testdb.

    user = work.user
    if not User.objects.using("testdb").filter(username = user.username).exists():
        User.objects.using("testdb").create(
            id = user.id,                # ⚠ keep the same id if possible
            username = user.username,
            email = user.email,
            password = user.password,    # hashed password
            is_superuser = user.is_superuser,
            is_staff = user.is_staff,
            is_active = user.is_active,
        )

    # Then backup the seasonal work.

    SeasonalWork.objects.using("testdb").create(
        name = work.name,
        character_type = work.character_type,
        year = work.year,
        season = work.season,
        summary = work.summary,
        description = work.description,
        time_created = work.time_created,
        user_id = work.user_id,
    )

def backup_user_and_work(user):
    
    """
    Example: backup user and all related SeasonalWork into the test DB.
    """

    # Save the user.

    User.objects.using("testdb").create(
        username = user.username,
        email = user.email,
        password = user.password,
        is_superuser = user.is_superuser,
        is_staff = user.is_staff,
        is_active = user.is_active,
    )

    # Save that user’s seasonal work.

    for work in SeasonalWork.objects.filter(user = user):
        
        SeasonalWork.objects.using("testdb").create(
            name = work.name,
            character_type = work.character_type,
            year = work.year,
            season = work.season,
            summary = work.summary,
            description = work.description,
            time_created = work.time_created,
            user_id = user.id,   # Careful: may not match IDs between DBs.
        )
