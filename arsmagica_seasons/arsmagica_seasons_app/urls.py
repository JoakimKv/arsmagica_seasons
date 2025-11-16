
# arsmagica_seasons_app/urls.py

from django.urls import path
from . import views
from .views import SeasonalWorkUpdateView, delete_seasonal_work


urlpatterns = [
    path("", views.index, name = "index"),
    path("login/", views.login_view, name = "login"),
    path("logout/", views.logout_view, name = "logout"),
    path("register/", views.register, name = "register"),
    path("change-password/", views.change_password, name = "change_password"),
    path("delete-account/<int:user_id>/", views.delete_account, name = "delete_account"),
    path("manage-users/", views.manage_users, name = "manage_users"),
    path("create/", views.seasonal_work_create, name = "seasonal_work_create"),
    path("<int:pk>/update/", SeasonalWorkUpdateView.as_view(), name = "update_seasonal_work"),
    path("<int:pk>/delete/", delete_seasonal_work, name = "delete_seasonal_work"),
    path("seasonal-work-detail/<int:pk>/", views.seasonal_work_detail, name = "seasonal_work_detail")
]
