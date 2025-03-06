# Use official Apache Airflow image
FROM apache/airflow:2.5.1

# Switch to airflow user
USER airflow

# Set working directory inside the container
WORKDIR /opt/airflow

# Copy all files from the local project directory to the container
COPY . /opt/airflow/

# Install required Python packages from requirements.txt
RUN pip install --no-cache-dir -r /opt/airflow/requirements.txt

# Create required directories and set permissions
RUN mkdir -p /opt/airflow/logs && chmod -R 777 /opt/airflow/logs /opt/airflow/dags

# Set environment variables for Airflow initialization
ENV AIRFLOW_HOME=/opt/airflow

# Command to initialize Airflow database and create admin user
ENTRYPOINT ["/bin/bash", "-c", "\
    airflow db init && \
    airflow users create --username admin --password admin --firstname Admin --lastname User --role Admin --email admin@example.com && \
    airflow scheduler & airflow webserver"]