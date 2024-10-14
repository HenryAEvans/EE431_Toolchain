set -x
xhost local:root
docker run -it -v /tmp/.X11-unix:/tmp/.X11-unix \
            -v /mnt/wslg:/mnt/wslg \
            -e DISPLAY \
            -e WAYLAND_DISPLAY \
            -e XDG_RUNTIME_DIR \
            -e PULSE_SERVER \
             --net=host -e DISPLAY ee431_toolchain bash