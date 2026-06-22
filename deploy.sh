#!/bin/bash

CONTAINER_NAME="ecommerce-app"
IMAGE_NAME="ecommerce-app"
IMAGE_TAG="v1"

echo "Stopping existing container..."

docker stop $CONTAINER_NAME 2>/dev/null
docker rm $CONTAINER_NAME 2>/dev/null

echo "Starting new container..."

docker run -d \
--name $CONTAINER_NAME \
-p 80:80 \
$IMAGE_NAME:$IMAGE_TAG

echo "Deployment completed."

docker ps