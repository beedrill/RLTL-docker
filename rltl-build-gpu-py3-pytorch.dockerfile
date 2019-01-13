# Python libSUMO Docker Image

FROM beedrill/rltl-docker:gpu-py3
MAINTAINER Benjamin Striner <bstriner@andrew.cmu.edu>

RUN pip install torch torchvision
