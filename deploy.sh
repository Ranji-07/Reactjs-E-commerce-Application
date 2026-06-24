#!/bin/bash

set -e

CONTAINER_NAME="ecommerce-app"

IMAGE_NAME=${1:-ecommerce-app}
IMAGE_TAG=${2:-v1}

echo "====================================="
echo "Deploying Application"
echo "Container : $CONTAINER_NAME"
echo "Image     : $IMAGE_NAME"
echo "Tag       : $IMAGE_TAG"
echo "====================================="

echo "Stopping existing container..."

docker stop $CONTAINER_NAME || true
docker rm $CONTAINER_NAME || true

echo "Starting new container..."

docker run -d \
  --name $CONTAINER_NAME \
  -p 80:80 \
  --restart always \
  $IMAGE_NAME:$IMAGE_TAG

echo ""
echo "Deployment completed."

docker ps