FROM bstriner/pysumo-docker
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
