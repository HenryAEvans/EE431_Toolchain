# Mac Install
if [[ "$OSTYPE" == "darwin"* ]]; then
    set -x

    xhost -
    xhost +localhost

    docker run -it \
        -v $(pwd)/workspace:/home/ee431/workspace:rw \
        -e DISPLAY=host.docker.internal:0 \
        ee431_toolchain bash

# Linux/WSL Install
else 
    set -x
    xhost local:root
    docker run -it -v $(pwd)/workspace:/home/ee431/workspace:rw\
                -v /tmp/.X11-unix:/tmp/.X11-unix \
                -v /mnt/wslg:/mnt/wslg \
                -e DISPLAY \
                -e WAYLAND_DISPLAY \
                -e XDG_RUNTIME_DIR \
                -e PULSE_SERVER \
                --net=host \
                 ee431_toolchain bash
fi
