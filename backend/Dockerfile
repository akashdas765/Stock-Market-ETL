# Use Python 3.10 as the base image for compatibility
FROM python:3.9-slim

# Set the working directory inside the container
WORKDIR /app

# Copy all local files into the container
COPY . .

# Upgrade pip to the latest version
RUN pip install --upgrade pip

# Install required Python packages
RUN pip install flask psycopg2-binary pandas numpy flask_cors

# Expose port for Flask
EXPOSE 5000

# Set environment variable for Flask to run in development mode
ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0

# Run the Flask application
CMD ["flask", "run"]