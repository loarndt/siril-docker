#!/bin/bash 

export DISPLAY=127.0.0.1:0.0

/opt/X11/bin/xhost + 127.0.0.1 

docker run --rm -ti -e DISPLAY=host.docker.internal:0  \
                    -v /Volumes/Astro:/Astro \
                    --entrypoint siril \
                    --name siril \
                    siril:latest
