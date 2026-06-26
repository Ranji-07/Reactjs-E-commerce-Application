#!/bin/bash

set -e

CONTAINER_NAME="ecommerce-app"

IMAGE_NAME=$1
IMAGE_TAG=$2

echo "Stopping old container..."

docker stop $CONTAINER_NAME || true

docker rm $CONTAINER_NAME || true

echo "Pulling latest image..."

docker pull $IMAGE_NAME:$IMAGE_TAG

echo "Starting new container..."

docker run -d \
  --name $CONTAINER_NAME \
  --restart always \
  -p 80:80 \
  $IMAGE_NAME:$IMAGE_TAG

echo "Deployment completed."

docker ps