#!/bin/bash

# See https://docs.docker.com/engine/reference/run/#runtime-privilege-and-linux-capabilities for more on capabilities

# Build kernel module. See escape.ko
make escape.ko

# Build escape image (just debian with insmod installed)
docker build -t escape .


# Use --privileged here, which adds lots of permissions
docker run \
       -it --rm \
       --privileged \
       escape insmod escape.ko
if [ -f /ESCAPED ]; then
    echo 'escape with --privileged successful!'
    sudo rm /ESCAPED
    sudo rmmod escape
else
    echo 'escape with --privileged unsuccessful!'
fi


# Grant just load+unload kmod capability
docker run \
       -it --rm \
       --cap-add=SYS_MODULE \
       escape insmod escape.ko
if [ -f /ESCAPED ]; then
    echo 'escape with --cap-add=SYS_MODULE successful!'
    sudo rm /ESCAPED
    sudo rmmod escape
else
    echo 'escape with --cap-add=SYS_MODULE unsuccessful!'
fi


# Grant just load+unload kmod capability as non-root
docker run \
       -it --rm \
       --cap-add=SYS_MODULE -u 1000 \
       escape insmod escape.ko
if [ -f /ESCAPED ]; then
    echo 'escape with --cap-add=SYS_MODULE -u 1000 successful!'
    sudo rm /ESCAPED
    sudo rmmod escape
else
    echo 'escape with --cap-add=SYS_MODULE -u 1000 unsuccessful!'
fi
