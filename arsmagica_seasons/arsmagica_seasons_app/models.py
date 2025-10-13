
# models.py


from django.db import models
from django.contrib.auth.models import User


class SeasonalWork(models.Model):
    
    SEASON_CHOICES = [(s, s) for s in ["Summer", "Autumn", "Winter", "Spring"]]
    CHARACTER_TYPE_CHOICES = [(s, s) for s in ["Magi", "Companion", "Other"]]

    name = models.CharField(max_length = 255)
    character_type = models.CharField(max_length = 12, choices = CHARACTER_TYPE_CHOICES)
    year = models.PositiveIntegerField()
    season = models.CharField(max_length = 12, choices = SEASON_CHOICES)
    summary = models.CharField(max_length = 455, blank = True)
    description = models.TextField()
    time_created = models.DateTimeField(auto_now_add = True)
    user = models.ForeignKey(User, on_delete = models.CASCADE)

    def __str__(self):
        return f"{self.year} ({self.season}) seasonal work for '{self.name}': {self.summary}"
    
    def clean_summary(self):

        """Allow blank summary so we can fill it with GPT later."""
        data = self.cleaned_data.get("summary")

        if data is None:

            return ""
        
        return data
    
    class Meta:
        
        # default ordering for queries
        ordering = ["year", "season", "name"]
