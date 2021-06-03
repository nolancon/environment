FROM ubuntu:18.04 

COPY scripts /root/.go-dev-env
RUN /root/.go-dev-env/image.sh
