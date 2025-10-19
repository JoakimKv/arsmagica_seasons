FROM python:3.12-slim


# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    default-libmysqlclient-dev \
    pkg-config \
    libssl-dev \
    libffi-dev \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /arsmagica_seasons_docker

# Copy dependency list first for caching
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

# Copy full source
COPY . .

# Expose port for Gunicorn
EXPOSE 8000

# Run Django via Gunicorn. Change into project dir so Python can import
# the inner package (arsmagica_seasons/arsmagica_seasons/wsgi.py).
CMD ["gunicorn", "-w", "4", "-b", "0.0.0.0:8000", "--chdir", "arsmagica_seasons", "arsmagica_seasons.wsgi:application"]

