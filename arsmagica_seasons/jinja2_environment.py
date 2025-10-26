
# arsmagica_seasons/jinja2_environment.py


from django.templatetags.static import static
from jinja2 import Environment
from django.urls import reverse


def environment(**options):
    
    """Configure and return a Jinja2 environment with Django-like globals."""

    env = Environment(**options)

    # Add commonly used Django functions to Jinja2 templates.
    env.globals.update({
        "static": static,
        "url": reverse,
    })

    return env
