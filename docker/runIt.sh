#!/bin/bash

# Pull the latest Legion Docker image
# Uncomment the following line if using the gvit image
# docker pull gvit/legion

echo "Starting Legion with Docker..."

if [[ ! -z $1 ]]
then
    export DISPLAY=$1:0.0
    XSOCK=/tmp/.X11-unix
    XAUTH=/tmp/.docker.xauth
    rm -f $XAUTH
    touch $XAUTH
    xauth add $DISPLAY . `mcookie`
    xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -
    docker run -ti \
        -v $XSOCK:/tmp/.X11-unix \
        -v $XAUTH:/tmp/.docker.xauth \
        -e XAUTHORITY=$XAUTH \
        -e DISPLAY=$DISPLAY \
        --net=host \
        --security-opt apparmor:unconfined \
        --security-opt label:disable \
        legion:latest
else
    docker run -ti \
        -e DISPLAY=$DISPLAY \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        --net=host \
        --security-opt apparmor:unconfined \
        --security-opt label:disable \
        legion:latest
fi
