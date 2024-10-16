# Debian 12, Python 3,11
FROM python:3.11.10-bookworm

WORKDIR /home/ee431
RUN apt update
# Install Core Tools
RUN apt install -y git magic ngspice tcl-tclreadline build-essential flex bison libxpm-dev libgtk-3-dev gettext
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
RUN aclocal
RUN autoheader
RUN automake --add-missing
RUN ./configure
RUN make
RUN make install
WORKDIR /home/ee431

RUN git clone https://github.com/RTimothyEdwards/open_pdks.git git_open_pdks
WORKDIR /home/ee431/git_open_pdks
RUN ./configure --enable-sky130-pdk --with-sky130-variants=all --with-reference
RUN make || true
RUN make install

WORKDIR /home/ee431
COPY xschemrc /home/ee431/xschemrc
RUN cp /usr/local/share/pdk/sky130A/libs.tech/xschem/xschemrc xschemrc2
RUN echo >> xschemrc
RUN cat xschemrc2 >> xschemrc

RUN rm -rf git_open_pdks
ENV HOME=/home/ee431
