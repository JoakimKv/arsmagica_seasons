
# pkg_views/seasons_views.py


from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.decorators import login_required
from django.db.models import Case, When, IntegerField
from django.urls import reverse_lazy
from django.views.generic import UpdateView

from ..pkg_models import SeasonalWork
from ..pkg_forms import SeasonalWorkForm
from ..pkg_utils import backup_seasonal_work_to_test
from ..gpthandler_class import GPTHandler


def home(request):

    """Homepage view for Kvistholm.net."""

    return render(request, "home/home.html")

class SeasonalWorkUpdateView(UpdateView):
    
    model = SeasonalWork
    form_class = SeasonalWorkForm
    template_name = "seasons/seasonal_work_form_jinja2.html"
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

        # After a successful update, go back to the homepage.
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
        "seasons/seasonal_work_form_jinja2.html",
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
