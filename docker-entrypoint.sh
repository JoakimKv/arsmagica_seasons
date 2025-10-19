#!/usr/bin/env sh
set -e

# Collect static files for production
python arsmagica_seasons/manage.py collectstatic --noinput

# Start Gunicorn
exec gunicorn -w 4 -b 0.0.0.0:8000 --chdir arsmagica_seasons arsmagica_seasons.wsgi:application

