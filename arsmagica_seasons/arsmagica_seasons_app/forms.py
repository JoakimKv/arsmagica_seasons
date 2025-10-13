
# arsmagica_seasons_app/forms.py


from django import forms
from django.contrib.auth.forms import UserCreationForm
from django.contrib.auth.models import User
from django.contrib.auth.password_validation import validate_password
from .models import SeasonalWork


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

class CustomUserCreationForm(UserCreationForm):
    
    email = forms.EmailField(required=True)

    class Meta:
        
        model = User
        fields = ("username", "email", "password1", "password2")

class ConfirmDeleteForm(forms.Form):
    
    password = forms.CharField(
        widget=forms.PasswordInput(attrs={'placeholder': 'Enter your password'}),
        label="Password"
    )

class ChangePasswordForm(forms.Form):
    
    current_password = forms.CharField(
        label="Current Password",
        widget=forms.PasswordInput
    )

    new_password = forms.CharField(
        label="New Password",
        widget=forms.PasswordInput,
        validators=[validate_password]  # use Django’s built-in password validators
    )

    confirm_password = forms.CharField(
        label="Confirm New Password",
        widget=forms.PasswordInput
    )

    def clean(self):
        
        cleaned_data = super().clean()
        new_password = cleaned_data.get("new_password")
        confirm_password = cleaned_data.get("confirm_password")

        if new_password and confirm_password and new_password != confirm_password:
            self.add_error("confirm_password", "New passwords do not match.")

        return cleaned_data
