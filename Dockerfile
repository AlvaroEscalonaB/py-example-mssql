# Use the official Python 3.11 image from the Docker Hub
FROM python:3.11-slim

# Set environment variables to prevent python from writing pyc files to disc
ENV PYTHONUNBUFFERED=1

ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies and add Microsoft ODBC repository
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    gnupg2 \
    unixodbc \
    libodbc1 \
    odbcinst1debian2 \
    build-essential \
    libpq-dev \ 
    && rm -rf /var/lib/apt/lists/* \
    && apt-get update \
    && curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --batch --yes --dearmor -o /usr/share/keyrings/microsoft-prod.gpg \
    && curl https://packages.microsoft.com/config/debian/12/prod.list | tee /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update \
    && ACCEPT_EULA=Y apt-get install -y msodbcsql18 \
    && rm -rf /var/lib/apt/lists/*

# Create and set the working directory inside the container
WORKDIR /app

# Copy the requirements.txt file to the container
COPY requirements.txt /app/

# Install the Python dependencies using pip
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the project files into the container
COPY . /app/

# Set the command to run your project (adjust if needed)
CMD ["python", "main.py"]
