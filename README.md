# EE431 Tool Chain
This is a containerized environment for VLSI development in Cal Poly EE431 to install and run the Magic VLSI suite along with the necessary dependencies. 

# Prepare for Installation
## Windows
To start, install [Docker Desktop](https://www.docker.com/products/docker-desktop/). Once set up, enable WSL integration so that your WSL instances can access docker.

![alt text](docs/docker.png)

## Mac

### Step 1: Install Docker
Install [Docker](https://www.docker.com/products/docker-desktop/). 

After installation open Docker from your mac, make an account and ensure the software is running.

### Step 2: Install and Setup XQuartz
Ensure XQuartz is Installed and Running:

1. Install XQuartz from https://www.xquartz.org/. Launch XQuartz after installation. Configure XQuartz to Allow Network Connections:
2. Go to XQuartz > Preferences > Security. Uncheck the option Authenticate connections. Check the option Allow connections from network clients.
3. Restart XQuartz for the changes to take effect.

## Linux

Install [Docker](https://www.docker.com/products/docker-desktop/). 

# Installation

### Step 1: Test Docker

Test that docker works by typing `docker`, making sure it does not warn you that you cannot access docker.

### Step 2: Installation

Once you have tested your Docker installation run the following command in your terminal in the location where you want the installation to take place.

```
git clone https://github.com/HenryAEvans/EE431_Toolchain.git
cd EE431_Toolchain
./install.sh
su $USER -c ./install.sh
logout
```

### Step 3: Log In
You might be logged out after the installation takes place. Simply log back in your computer and the installation will be complete. 

# Running Magic

### Step 1: Enter the Container
To run magic, navigate to the directory where it is installed eg. `cd ~/EE431_Toolchain` then run the following command to enter the container


### Step 2: Create a Project
A project template has been created for you and resides in the home directory, you can make a copy of this and place it in the `workspace/` directory with the following command:

``` shell
cp -R magic_template_project workspace/<project_name>
```
> [!CAUTION]
> Anything you don't place in the `workspace/` directory will be deleted when you restart the container

### Step 3: Start Magic
Then you can cd into the new project and start magic with:

``` shell
magic -rcfile=sky130A.magicrc
```

