#!/bin/bash

# Define Azure Container Registry (ACR) name
ACR_NAME="akashdas62etlregistry.azurecr.io"

# List of services and their corresponding directories
SERVICES=(
  "frontend"
  "backend"
  "spark_consumer"
  "kafka_producer"
  "airflow"
)

# Loop through each service, rebuild, tag, and push
for SERVICE in "${SERVICES[@]}"; do
  echo "---------------------------------------------"
  echo "Building Docker image for $SERVICE..."
  echo "---------------------------------------------"

  # Navigate to the directory
  if [ -d "$SERVICE" ]; then
    cd "$SERVICE" || exit

    # Build the Docker image
    docker build -t akashdas62/$SERVICE:latest .

    # Tag the image for Azure Container Registry
    docker tag akashdas62/$SERVICE:latest $ACR_NAME/$SERVICE:latest

    # Push the image to Azure Container Registry
    docker push $ACR_NAME/$SERVICE:latest

    echo "$SERVICE image successfully pushed to Azure!"

    # Go back to the parent directory
    cd ..
  else
    echo "Directory $SERVICE does not exist. Skipping..."
  fi
done

echo "All Docker images have been rebuilt and pushed successfully!"