
# context_processors.py


from django.conf import settings


def blogs_url(request):
    
    """Add dynamic BLOGS_URL to all templates."""

    blogs_url = "https://kvistholm.net/blogs/" if not settings.DEBUG else "http://localhost:5000/blogs/"

    return {"BLOGS_URL": blogs_url}
