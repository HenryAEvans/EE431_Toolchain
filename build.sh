if ! $(which docker); then
    echo Please install docker https://www.docker.com/products/docker-desktop/
    echo If running on WSL, install docker desktop on windows. You might have to enable the docker/wsl integration in the docker desktop settings.
    exit 1
fi

if ! $(which xhost); then
    if ! (sudo apt update && sudo apt -y install x11-xserver-utils); then
        echo Please install xhost on your machine. Run the following:
        echo sudo apt install x11-xserver-utils
        exit 1
    fi;
fi
if [[ "$OSTYPE" == "darwin"* ]]; then
    # Mac OSX
    if ! $(which Xquartz); then
        echo Please verify that you have installed Xquartz and followed the permission instructions on Git Hub for Mac.
        exit 1
    fi

fi

docker build . -t ee431_toolchain
if ! [ $? -eq 0 ]; then
    sudo groupadd docker || true
    sudo usermod -aG docker $USER
    sudo chmod 770 /var/run/docker.sock
    echo "Log out, Log In, and Re Run This Script."
fi
