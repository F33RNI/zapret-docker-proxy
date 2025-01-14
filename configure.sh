#!/bin/bash

# Make sure container is stopped
./stop.sh

# Build and start container
docker-compose up --build -d

# Wait for the container to be ready
until docker exec zapret-proxy echo "Container is ready"; do
  echo "Waiting for container to start..."
  sleep 2
done

# Enable and start services
sudo docker exec zapret-proxy ./enable_services.sh

# Run blockcheck.sh
sudo docker exec zapret-proxy ./run_blockcheck_in_container.sh

# Generate new config
sudo ./scripts/form_config.sh

# Reinstall zapret
sudo docker exec zapret-proxy ./start_zapret.sh
