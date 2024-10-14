FROM debian:12
WORKDIR /home/ee431
RUN apt update
RUN apt install -y magic xschem ngspice
