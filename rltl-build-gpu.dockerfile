# Python 2.7 libSUMO Docker Image

FROM tensorflow/tensorflow:latest-gpu
MAINTAINER Benjamin Striner <bstriner@andrew.cmu.edu>

## Basics
RUN apt-get update --fix-missing
RUN apt-get install -y software-properties-common
RUN apt-get install -y apt-utils
RUN apt-get install -y gcc
RUN apt-get install -y make
RUN apt-get install -y cmake
RUN apt-get install -y build-essential
RUN apt-get install -y git
RUN dpkg --configure -a

## Python
RUN apt-get install -y python python-dev python-pip
RUN python -m pip install --upgrade pip

## SUMO Dependencies
# Swig
RUN apt-get install -y swig
# XercesC
RUN apt-get install -y libxerces-c-dev
# GDAL
RUN apt-get install -y libgdal-dev
# proj
RUN apt-get install -y libproj-dev
# FOX
RUN apt-get install -y libfox-1.6-0 libfox-1.6-dev

## SUMO Install
WORKDIR /home

# RUN git clone https://github.com/eclipse/sumo.git
RUN git clone -b libsumo_close https://github.com/bstriner/sumo-1.git sumo
RUN apt-get install wget
RUN wget https://cmake.org/files/v3.11/cmake-3.11.3.tar.gz
RUN tar xzf cmake-3.11.3.tar.gz
RUN cd cmake-3.11.3 && cmake . && cmake --build . --config Release --target install
RUN cd sumo && mkdir build27 && cd build27 && cmake -DPython_ADDITIONAL_VERSIONS=2.7 -DCMAKE_BUILD_TYPE=Release .. && cmake --build . --target install_pylibsumo --config Release

#install sumo
RUN add-apt-repository ppa:sumo/stable
RUN apt-get update
RUN apt-get install -y sumo sumo-tools sumo-doc

#install tensorflow
RUN pip install --upgrade tensorflow

#install all requirement
RUN mkdir /data
COPY requirements.txt /data
WORKDIR /data
RUN pip install -U -r requirements.txt
WORKDIR /home
