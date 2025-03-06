#!/bin/bash

# Prompt for Docker image name
read -p "Enter Docker image name: " IMAGE_NAME

# Prompt for Docker container name
read -p "Enter Docker container name: " CONTAINER_NAME

# Enable X11 forwarding for GUI applications
XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth

# Create X11 auth file if it doesn't exist
touch $XAUTH
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -

# Run the Docker container with all required options
docker run -it --rm \
    --gpus all \
    --network host \
    --env DISPLAY=$DISPLAY \
    --env QT_X11_NO_MITSHM=1 \
    --volume $XSOCK:$XSOCK:rw \
    --volume $XAUTH:$XAUTH:rw \
    --env XAUTHORITY=$XAUTH \
    --name $CONTAINER_NAME \
    $IMAGE_NAME bash
