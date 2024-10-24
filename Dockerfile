# Debian 12, Python 3,11
FROM python:3.11.10-bookworm

WORKDIR /home/ee431
RUN apt update
# Install Core Tools
RUN apt install -y git ngspice tcl-tclreadline build-essential flex \
    bison libxpm-dev libgtk-3-dev gettext m4 tcsh csh libx11-dev tcl-dev \
    tk-dev libcairo2-dev libncurses-dev blt freeglut3-dev mesa-common-dev \
    libgl1-mesa-dev libglu1-mesa-dev xterm

# Install Magic
RUN git clone https://github.com/RTimothyEdwards/magic.git git_magic
WORKDIR /home/ee431/git_magic
RUN ./configure --prefix=/usr
RUN make
RUN make install
ENV CAD_ROOT=/usr/lib/
WORKDIR /home/ee431

# Install XSchem
RUN wget http://repo.hu/projects/xschem/releases/xschem-3.4.4.tar.gz
RUN tar xzvf xschem-3.4.4.tar.gz
WORKDIR /home/ee431/xschem-3.4.4
RUN ./configure --prefix=/usr
RUN make
RUN make install
WORKDIR /home/ee431

# Install GAW3
RUN git clone https://github.com/StefanSchippers/xschem-gaw.git
WORKDIR /home/ee431/xschem-gaw
RUN sed -i 's/GETTEXT_MACRO_VERSION = 0.18/GETTEXT_MACRO_VERSION = 0.20/g' po/Makefile.in.in
RUN aclocal &&\
    autoheader &&\
    automake --add-missing &&\
    ./configure &&\
    make &&\    
    make install
WORKDIR /home/ee431

# Install OpenPDK
RUN git clone https://github.com/RTimothyEdwards/open_pdks.git git_open_pdks
WORKDIR /home/ee431/git_open_pdks
RUN ./configure --enable-sky130-pdk --with-sky130-variants=all --with-reference
RUN make -k
RUN make install
ENV PDK_ROOT=/usr/local/share/pdk

# Configure Magic with OpenPDK
RUN ln -sf $PDK_ROOT/sky13A/libs.tech/magic/* $CAD_ROOT/magic/sys/
RUN mkdir magic_template_project
WORKDIR /home/ee431/magic_template_project
RUN cp $PDK_ROOT/sky130A/libs.tech/magic/sky130A.magicrc .

# Configure XSchem with OpenPDK
WORKDIR /home/ee431
COPY xschemrc /home/ee431/xschemrc
RUN cp /usr/local/share/pdk/sky130A/libs.tech/xschem/xschemrc xschemrc2
RUN echo >> xschemrc
RUN cat xschemrc2 >> xschemrc

# Clean Up Artifacts
RUN rm -rf git_open_pdks git_magic/ xschem-3.4.4 xschem-3.4.4.tar.gz xschem-gaw/ xschemrc2
ENV HOME=/home/ee431
