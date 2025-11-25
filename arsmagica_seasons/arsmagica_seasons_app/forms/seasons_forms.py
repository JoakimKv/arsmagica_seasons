
# pkg_forms/seasons_forms.py


from django import forms
from ..models import SeasonalWork


class SeasonalWorkForm(forms.ModelForm):
    
    class Meta:
        
        model = SeasonalWork
        fields = ["name", "character_type", "year", "season", "summary", "description"]
        widgets = {
            "description": forms.Textarea(attrs={"rows": 12, "columns": 120, "class": "form-control"}),
            "name": forms.TextInput(attrs={"class": "form-control"}),
            "year": forms.NumberInput(attrs={"class": "form-control"}),
            "summary": forms.TextInput(attrs={
               "class": "form-control",
               "placeholder": "Add text or leave blank to let ChatGPT summarize the description."
            }),
            "season": forms.Select(attrs={"class": "form-select"}),
            "character_type": forms.Select(attrs={"class": "form-select"}),
        }
