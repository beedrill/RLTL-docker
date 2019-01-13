FROM bstriner/pysumo-docker
#install sumo
RUN add-apt-repository ppa:sumo/stable
RUN apt-get update
RUN apt-get install -y sumo sumo-tools sumo-doc

#install tensorflow
RUN pip3 install --upgrade pip
RUN apt update
RUN apt install -y libsm6 libxext6
RUN apt install -y libopenmpi-dev
RUN pip3 install --upgrade tensorflow
RUN pip3 install --upgrade opencv-python

#install all requirement
RUN mkdir /data
COPY requirements.txt /data
WORKDIR /data
RUN pip3 install -U -r requirements.txt
WORKDIR /home

ENV OPENAI_LOG_FORMAT='stdout,log,csv,tensorboard'
ENV OPENAI_LOGDIR=/home/gym/logs/
ENV SUMO_HOME=/home/sumo
