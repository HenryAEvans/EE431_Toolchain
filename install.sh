if ! $(which docker); then
    echo Please install docker https://www.docker.com/products/docker-desktop/
    echo If running on WSL, install docker desktop on windows. You might have to enable the docker/wsl integration in the docker desktop settings.
    exit 1
fi

if ! $(which xhost); then
    # sudo apt install install x11-xserver-utils
    # if 
    echo Please install xhost on your machine. Run the following:
    echo sudo apt install x11-xserver-utils
    exit 1
fi

sudo chmod 777 /var/run/docker.sock
docker build . -t ee431_toolchain 