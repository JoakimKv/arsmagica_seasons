
# views/__init__.py


from .auth_views import (
    logout_view,
    register,
    login_view,
    change_password
)

from .seasons_views import (
    home,
    SeasonalWorkUpdateView,
    seasonal_work_create,
    delete_seasonal_work,
    index,
    seasonal_work_detail
)

from .admin_views import (
    delete_user,
    manage_users,
    delete_account
)


__all__ = [
  'logout_view',
  'register',
  'login_view',
  'change_password',
  'home',
  'SeasonalWorkUpdateView',
  'seasonal_work_create',
  'delete_seasonal_work',
  'index',
  'seasonal_work_detail',
  'delete_user',
  'manage_users',  
  'delete_account'
]
