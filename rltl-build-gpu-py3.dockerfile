# Python libSUMO Docker Image

FROM nvidia/cuda:9.0-cudnn7-devel-ubuntu16.04
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
RUN apt-get install wget

## Python
RUN apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:jonathonf/python-3.6
RUN apt-get update
RUN apt-get install -y python3.6 python3.6-dev
RUN apt-get install -y python3.6-venv
RUN wget https://bootstrap.pypa.io/get-pip.py
RUN python3.6 get-pip.py
RUN ln -s /usr/bin/python3.6 /usr/local/bin/python3
#RUN ln -s /usr/local/bin/pip /usr/local/bin/pip3

#RUN apt-get install -y python3 python3-dev python3-pip
#RUN python3 -m pip install --upgrade pip

##tensorflow
RUN pip install tensorflow-gpu

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
##RUN apt-get install wget
RUN wget https://cmake.org/files/v3.11/cmake-3.11.3.tar.gz
RUN tar xzf cmake-3.11.3.tar.gz
RUN cd cmake-3.11.3 && cmake . && cmake --build . --config Release --target install
RUN cd sumo && mkdir build36 && cd build36 && cmake -DPython_ADDITIONAL_VERSIONS=3.6 -DCMAKE_BUILD_TYPE=Release .. && cmake --build . --target install_pylibsumo --config Release

#install sumo
RUN add-apt-repository -y ppa:sumo/stable
RUN apt-get update
RUN apt-get install -y sumo sumo-tools sumo-doc


#install all requirement
RUN mkdir /data
COPY requirements.txt /data
WORKDIR /data
RUN pip install -U -r requirements.txt
WORKDIR /home
