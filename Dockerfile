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
    && pip install --no-cache-dir -r requirements.txt \
    && pip install --no-cache-dir whitenoise==6.8.2

# Copy full source
COPY . .

# Expose port for Gunicorn
EXPOSE 8000

# Copy entrypoint and make executable
COPY docker-entrypoint.sh ./docker-entrypoint.sh
RUN chmod +x ./docker-entrypoint.sh

# Run entrypoint (collectstatic + gunicorn)
ENTRYPOINT ["./docker-entrypoint.sh"]

