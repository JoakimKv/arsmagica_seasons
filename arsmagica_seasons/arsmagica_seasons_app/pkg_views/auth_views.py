
# pkg_views/auth_views.py


from django.shortcuts import render, redirect
from django.contrib.auth import login, logout, update_session_auth_hash
from django.contrib.auth.forms import AuthenticationForm
from django.contrib.auth.decorators import login_required
from django.contrib import messages

from ..pkg_forms import CustomUserCreationForm, ChangePasswordForm


@login_required
def logout_view(request):
    
    logout(request)

    return redirect("index")

def register(request):
    
    if request.method == "POST":
        
        form = CustomUserCreationForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect("login")  # Redirect to login page after registration.
    else:
        form = CustomUserCreationForm()

    return render(request, "auth/register.html", {"form": form})

def login_view(request):
    
    if request.method == "POST":

        form = AuthenticationForm(request, data = request.POST)

        if form.is_valid():
            user = form.get_user()
            login(request, user)
            return redirect("index")  # Redirect after login.
    else:
        form = AuthenticationForm()

    return render(request, "auth/login.html", {"form": form})

@login_required
def change_password(request):

    if request.method == "POST":

        form = ChangePasswordForm(request.POST)

        if form.is_valid():

            current_password = form.cleaned_data["current_password"]
            new_password = form.cleaned_data["new_password"]

            # Verify current password
            if not request.user.check_password(current_password):
                form.add_error("current_password", "Current password is incorrect.")
            else:
                request.user.set_password(new_password)
                request.user.save()

                # Keep user logged in after password change
                update_session_auth_hash(request, request.user)

                messages.success(request, "Password updated successfully.")
                return redirect("index")
    else:
        form = ChangePasswordForm()

    return render(request, "auth/change_password.html", {"form": form})
