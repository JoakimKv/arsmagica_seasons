
# views.py


from django.shortcuts import render, redirect, get_object_or_404

from django.db.models import Case, When, IntegerField
from .models import SeasonalWork

from .forms import CustomUserCreationForm
from .forms import ConfirmDeleteForm

from django.contrib.auth.forms import AuthenticationForm
from django.contrib.auth import login

from django.contrib.auth.decorators import user_passes_test
from django.contrib.auth.models import User
from django.contrib.auth import authenticate

from django.shortcuts import get_object_or_404, redirect
from django.contrib import messages
from .utils import backup_user_and_work

from django.contrib.auth.decorators import login_required

from .utils import backup_user_and_work, backup_seasonal_work_to_test
from .forms import SeasonalWorkForm
from .gpthandler_class import GPTHandler

from django.views.generic import UpdateView
from django.urls import reverse_lazy

from django.contrib.auth import logout
from .forms import ChangePasswordForm
from django.contrib.auth import update_session_auth_hash


@login_required
def logout_view(request):
    
    logout(request)
    return redirect("index")

class SeasonalWorkUpdateView(UpdateView):
    
    model = SeasonalWork
    form_class = SeasonalWorkForm
    template_name = "seasons/seasonal_work_form.html"
    context_object_name = "work"

    def form_valid(self, form):

        work = form.save(commit=False)

        if not work.summary.strip():

            gpt = GPTHandler()
            summarized_text = gpt.summarizeText(work.description)
            work.summary = summarized_text or "Auto-generated summary unavailable."

        work.save()

        return super().form_valid(form)
    
    def get_success_url(self):
        # After a successful update, go back to the homepage
        return reverse_lazy("index")

    def get_queryset(self):
        
        """
        Ensure users can only edit their own seasonal work
        """

        qs = super().get_queryset()

        return qs.filter(user = self.request.user)
    
@login_required
def seasonal_work_create(request):

    if request.method == "POST":

        form = SeasonalWorkForm(request.POST)

        if form.is_valid():

            work = form.save(commit=False)
            work.user = request.user

            # If summary was blank, auto-fill using GPT.
            if not work.summary.strip():

                gpt = GPTHandler()
                summarized_text = gpt.summarizeText(work.description)
                work.summary = summarized_text or "Auto-generated summary unavailable."

            work.save()

            return redirect("index")
        
    else:

        form = SeasonalWorkForm()

    return render(
        request,
        "seasons/seasonal_work_form.html",
        {"form": form, "work": None}
    )

@login_required
def delete_seasonal_work(request, pk):
    
    # Only allow the logged-in user to delete their own work
    work = get_object_or_404(SeasonalWork, pk = pk, user = request.user)

    if request.method == "POST":
        
        # 1. Backup to test database.
        backup_seasonal_work_to_test(work)

        # 2. Delete from default database.
        work.delete()

        # 3. Redirect back to index (or work list).
        return redirect("index")

    # If GET -> show confirmation page.
    return render(request, "seasons/seasonal_work_confirm_delete.html", {"work": work})

def delete_user(request, user_id):
    
    # Only superuser joakim can do this
    if not (request.user.is_superuser and request.user.username == "joakim"):
        messages.error(request, "You are not authorized to delete accounts.")
        return redirect("index")

    user = get_object_or_404(User, id = user_id)

    # Prevent deleting yourself or admin
    if user.username in ["joakim", "admin"]:
        messages.error(request, "You cannot delete this account.")
        return redirect("index")

    # Backup first
    success, msg = backup_user_and_work(user.id)
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

def register(request):
    
    if request.method == "POST":
        form = CustomUserCreationForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect("login")  # redirect to login page after registration
    else:
        form = CustomUserCreationForm()

    return render(request, "auth/register.html", {"form": form})

def login_view(request):
    
    if request.method == "POST":

        form = AuthenticationForm(request, data = request.POST)

        if form.is_valid():
            user = form.get_user()
            login(request, user)
            return redirect("index")  # redirect after login
    else:
        form = AuthenticationForm()

    return render(request, "auth/login.html", {"form": form})

def index(request):
    
    # Annotate so seasons are sortable in your custom order
    works = SeasonalWork.objects.annotate(
        season_sort=Case(
            When(season = "Summer", then = 1),
            When(season = "Autumn", then = 2),
            When(season = "Winter", then = 3),
            When(season = "Spring", then = 4),
            output_field=IntegerField(),
        ),
        character_type_sort=Case(
            When(character_type = "Magi", then = 1),
            When(character_type = "Companion", then = 2),
            When(character_type = "Other", then = 3),
            output_field=IntegerField(),
        )
    ).order_by("year", "season_sort", "name")

    return render(request, "seasons/index.html", {"works": works})

def seasonal_work_detail(request, pk):
    
    work = get_object_or_404(SeasonalWork, pk = pk)
    return render(request, "seasons/seasonal_work_detail.html", {"work": work})

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
