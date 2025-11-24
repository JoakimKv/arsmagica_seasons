# arsmagica_seasons_app/__init__.py

# Lazy-export the top-level views module so `from arsmagica_seasons_app import views` works
# without triggering imports before Django apps are ready.
import importlib
from typing import TYPE_CHECKING

__all__ = ["views"]


def __getattr__(name):
    
    if name == "views":
        return importlib.import_module(".views", __name__)
    raise AttributeError(f"module {__name__!r} has no attribute {name!r}")


if TYPE_CHECKING:
    from . import views  # type: ignore  # for static analyzers only
