#!/bin/bash

# Start the DRM service in the background
/opt/dell/dellrepositorymanager/DRM_Service.sh &

# DRM binds to localhost:8090 inside container and socat is needed to make it accessible on *:8091
socat tcp-listen:8091,reuseaddr,fork tcp:127.0.0.1:8090
