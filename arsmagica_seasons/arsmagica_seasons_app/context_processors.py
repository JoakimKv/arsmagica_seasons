
# context_processors.py


from django.conf import settings
from django.middleware.csrf import get_token
from django.utils.safestring import mark_safe


def blogs_url(request):
    
    """Expose BLOGS_URL from settings to templates."""

    return {"BLOGS_URL": settings.BLOGS_URL}

def jinja2_csrf(request):

    """Generate csrf_input for Jinja2 templates."""

    token = get_token(request)
    
    return {
        "csrf_input": mark_safe(
            f'<input type="hidden" name="csrfmiddlewaretoken" value="{token}">'
        )
    }
