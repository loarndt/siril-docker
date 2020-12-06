FROM ubuntu:latest

MAINTAINER Lothar Arndt <lothar.arndt@equality-it.com.au>

RUN apt update && \
    ln -s /usr/share/zoneinfo/Europe/Berlin /etc/localtime && \
    apt install -y build-essential g++ libx11-dev libxi-dev libpng-dev curl wget \
    vim jq bc git iputils-ping tzdata software-properties-common \
    libgtk-3-dev \
    meson \ 
    ninja-build \
    cmake && \
    dpkg-reconfigure --frontend noninteractive tzdata && \ 
    apt install -y libfftw3-dev \
    libgsl-dev \ 
    libconfig-dev \ 
    libopencv-dev \ 
    libraw-dev \
    libffms2-dev \
    libtiff-dev \
    libjpeg-dev \ 
    libheif-dev \
    libpng-dev \ 
    libavformat-dev \
    libavutil-dev \
    libavcodec-dev \
    libswscale-dev \
    libswresample-dev \
    libghc-criterion-dev \
    gnuplot && \
    apt clean autoclean && \
    apt autoremove --yes && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/ 

RUN cd /usr/local/src ; wget http://heasarc.gsfc.nasa.gov/FTP/software/fitsio/c/cfitsio-3.49.tar.gz ;  tar -zxvf cfitsio-3.49.tar.gz  ; rm cfitsio-3.49.tar.gz  ; \
    cd /usr/local/src/cfitsio-3.49 ; ./configure --prefix=/usr ; make ; make install ; make clean  

RUN cd /usr/local/src ; wget https://www.exiv2.org/builds/exiv2-0.27.3-Source.tar.gz ; tar -zxvf exiv2-0.27.3-Source.tar.gz ; rm exiv2-0.27.3-Source.tar.gz ; \
    cd /usr/local/src/exiv2-0.27.3-Source ; cmake . ; make ; make install ; make clean  

RUN cd /usr/local/src ; git clone https://gitlab.com/free-astro/siril.git ; cd siril ; git checkout 0.99.6 ; git submodule sync --recursive ; git submodule update --init --recursive ; \
  meson --buildtype release _build ; \
  ninja -C _build ; \
  ninja -C _build install

ENV DEBIAN_FRONTEND=noninteractive
ENV LD_LIBRARY_PATH=/usr/local/lib/ 
