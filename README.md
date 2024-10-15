# EE431_Toolchain
This is a containerized environment for VLSI development in Cal Poly EE431

# Install Docker
## Windows
To start, install [Docker Desktop](https://www.docker.com/products/docker-desktop/). Once set up, enable WSL integration so that your WSL instances can access docker.

![alt text](docs/docker.png)
## Mac
Install [Docker](https://www.docker.com/products/docker-desktop/). Support Unknown.

# One Line Installer
First, test that docker works by typing `docker`, making sure it does not warn you that you cannot access docker.
Once docker is installed, paste this into your terminal.
```
git clone https://github.com/HenryAEvans/EE431_Toolchain.git
cd EE431_Toolchain
./install.sh
su $USER -c ./install.sh
logout
```
Then, log back in. To use the tools, `cd ~/EE431_Toolchain` and run `./run.sh` to enter the container. 
