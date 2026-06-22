#!/bin/bash

IMAGE_NAME="ecommerce-app"
IMAGE_TAG="v1"

echo "Building Docker image..."

docker build -t $IMAGE_NAME:$IMAGE_TAG .

if [ $? -eq 0 ]; then
    echo "Docker image built successfully."
else
    echo "Docker build failed."
    exit 1
fi

echo "Available Images:"
docker images | grep $IMAGE_NAME