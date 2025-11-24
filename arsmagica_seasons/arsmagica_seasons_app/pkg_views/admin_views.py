
# pkg_views/admin_views.py


from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.models import User
from django.contrib.auth import authenticate
from django.contrib import messages
from django.contrib.auth.decorators import user_passes_test

from ..pkg_forms import ConfirmDeleteForm
from ..pkg_utils import backup_user_and_work


def delete_user(request, user_id):
    
    # Only superuser joakim can do this.
    if not (request.user.is_superuser and request.user.username == "joakim"):
        messages.error(request, "You are not authorized to delete accounts.")
        return redirect("index")

    user = get_object_or_404(User, id = user_id)

    # Prevent deleting yourself or admin
    if user.username in ["joakim", "admin"]:
        messages.error(request, "You cannot delete this account.")
        return redirect("index")

    # Backup first
    msg = backup_user_and_work(user)
    messages.info(request, msg)

    # Then delete from default DB
    user.delete()

    messages.success(request, f"User {user.username} deleted successfully.")
    return redirect("index")

@user_passes_test(lambda u: u.is_superuser and u.username == "joakim")
def manage_users(request):
    
    # exclude joakim from the list.
    users = User.objects.exclude(username__in = ["joakim", "admin"]).order_by("id")
    return render(request, "auth/manage_users.html", {"users": users})

@user_passes_test(lambda u: u.is_superuser and u.username == "joakim")
def delete_account(request, user_id):
    
    user_to_delete = get_object_or_404(User, pk = user_id)

    if user_to_delete.username == "joakim":
        
        # prevent self-deletion
        return redirect("index")

    if request.method == "POST":
        
        form = ConfirmDeleteForm(request.POST)
        if form.is_valid():
            password = form.cleaned_data["password"]

            # verify that current logged-in user (joakim) confirms password.
            if authenticate(username=request.user.username, password=password):
                user_to_delete.delete()
                return redirect("index")
            else:
                form.add_error("password", "Incorrect password.")
    else:
        form = ConfirmDeleteForm()

    return render(request, "auth/delete_account.html", {
        "form": form,
        "user_to_delete": user_to_delete
    })
