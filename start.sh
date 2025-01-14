#!/bin/bash

# Make sure container is stopped
./stop.sh

# Build and start container
docker-compose build
docker-compose up -d

# Wait for the container to be ready
until docker exec zapret-proxy echo "Container is ready"; do
  echo "Waiting for container to start..."
  sleep 2
done

# Execute starting script
docker exec -it zapret-proxy ./start_zapret.sh
