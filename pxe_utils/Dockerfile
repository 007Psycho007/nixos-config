# Use an official Python runtime as a base image
FROM python:3.12-bullseye

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Set work directory
WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

RUN apt update -y && apt install cups cups-bsd -y
# Copy the project files
COPY . .

# Expose the port Gunicorn will run on
EXPOSE 5000

# Run the app using Gunicorn
CMD ["gunicorn", "-w", "4", "-b", "0.0.0.0:5000", "app:app"]

