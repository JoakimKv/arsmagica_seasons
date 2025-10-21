
# context_processors.py


from django.conf import settings


def blogs_url(request):
    
    """Expose BLOGS_URL from settings to templates."""

    return {"BLOGS_URL": settings.BLOGS_URL}
