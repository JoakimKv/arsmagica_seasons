
# forms/__init__.py


from .auth_forms import (
    CustomUserCreationForm,
    ConfirmDeleteForm,
    ChangePasswordForm,
)

from .seasons_forms import SeasonalWorkForm


__all__ = [
  'CustomUserCreationForm',
  'ConfirmDeleteForm',
  'ChangePasswordForm',
  'SeasonalWorkForm'
]
