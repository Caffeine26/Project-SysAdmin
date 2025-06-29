# Use official Python base image
FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Copy all project files into the container
COPY . .

# Download wait-for-it script and make it executable
ADD https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh /wait-for-it.sh
RUN chmod +x /wait-for-it.sh

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose the Flask port
EXPOSE 5000

# Run the Flask app using Gunicorn, waiting for db before starting
CMD ["/wait-for-it.sh", "db:3306", "--", "gunicorn", "-w", "4", "-b", "0.0.0.0:5000", "app:app"]
