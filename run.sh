# Select Local or Remote Container
if [ "$1" = "-l" ] || [ "$1" = "--local" ]; then
    CONTAINER=ee431_toolchain
else 
    CONTAINER=fwilken/ee431_toolchain:v1.1s
fi

# Mac Install
if [[ "$OSTYPE" == "darwin"* ]]; then
    set -x

    xhost -
    xhost +localhost

    docker run -it --rm \
	--platform linux/amd64 \
        -v $(pwd)/workspace:/home/ee431/workspace:rw \
        -e DISPLAY=host.docker.internal:0 \
        -e "TERM=xterm-256color"\
        --hostname ee431-docker \
        $CONTAINER bash

# Linux/WSL Install
else 
    set -x
    xhost local:root
    docker run -it --rm -v $(pwd)/workspace:/home/ee431/workspace:rw\
                -v /tmp/.X11-unix:/tmp/.X11-unix \
                -v /mnt/wslg:/mnt/wslg \
                -e DISPLAY \
                -e WAYLAND_DISPLAY \
                -e XDG_RUNTIME_DIR \
                -e PULSE_SERVER \
                -e "TERM=xterm-256color"\
                --hostname ee431-docker \
                --net=host \
                $CONTAINER bash
fi
