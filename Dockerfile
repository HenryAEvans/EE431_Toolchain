# Debian 12, Python 3,11
FROM python:3.11.10-bookworm

WORKDIR /home/ee431
RUN apt update
# Install Core Tools
RUN apt install -y magic xschem ngspice tcl-tclreadline
# Install Open PDK
RUN apt install -y git
RUN git clone https://github.com/RTimothyEdwards/open_pdks.git git_open_pdks
WORKDIR /home/ee431/git_open_pdks
RUN ./configure --enable-sky130-pdk --with-sky130-variants=all --prefix=/home/ee431 --with-reference
RUN make || true
RUN make install

WORKDIR /home/ee431
# RUN mkdir -p /home/ee431/.xschem
# RUN cp /usr/share/xschem/xschemrc /home/ee431/.xschem/xschemrc
COPY xschemrc /home/ee431/xschemrc
# RUN cat xschemrc >> /usr/share/xschem/xschemrc
RUN cp share/pdk/sky130A/libs.tech/xschem/xschemrc xschemrc2
RUN echo >> xschemrc 
RUN cat xschemrc2 >> xschemrc
