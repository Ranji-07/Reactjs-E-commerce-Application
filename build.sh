#!/bin/bash

set -e

IMAGE_NAME=${1:-ecommerce-app}
IMAGE_TAG=${2:-v1}

echo "====================================="
echo "Building Docker Image"
echo "Image Name : $IMAGE_NAME"
echo "Image Tag  : $IMAGE_TAG"
echo "====================================="

docker build -t $IMAGE_NAME:$IMAGE_TAG .

echo ""
echo "Build completed successfully."

echo ""
echo "Available Images:"
docker images | grep $IMAGE_NAME