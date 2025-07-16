# Stage 1: Build Stage
# Use a Python base image for building dependencies
FROM python:3.11-slim-buster AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy the requirements file into the container
COPY requirements.txt .

# Install Python dependencies
# Using --no-cache-dir to prevent pip from storing downloaded packages,
# which reduces the image size.
# Using --upgrade pip to ensure pip is up-to-date.
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Stage 2: Production Stage
# Use a smaller, production-ready Python base image
FROM python:3.11-slim-buster

# Set the working directory inside the container
WORKDIR /app

# Copy only the installed packages from the builder stage
COPY --from=builder /usr/local/lib/python3.11/site-packages /usr/local/lib/python3.11/site-packages

# Copy the application code into the container
# Assuming your FastAPI application file is named main.py and is in the same directory as the Dockerfile
COPY main.py .

# Expose the port that FastAPI/Uvicorn will listen on
# The default port for Uvicorn is 8000
EXPOSE 8000

# Command to run the FastAPI application using Uvicorn
# --host 0.0.0.0 makes the server accessible from outside the container
# --port 8000 specifies the port
# main:app refers to the 'app' object in 'main.py'
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]

# To build this Docker image:
# 1. Make sure you have Docker Desktop installed and running.
# 2. Navigate to the directory containing your Dockerfile and main.py (and requirements.txt).
# 3. Run the command: docker build -t your-image-name:latest .
#
# To push this image to a container registry (e.g., Azure Container Registry for AKS):
# 1. Log in to your registry: docker login yourregistry.azurecr.io
# 2. Tag your image: docker tag your-image-name:latest yourregistry.azurecr.io/your-image-name:latest
# 3. Push the image: docker push yourregistry.azurecr.io/your-image-name:latest
