FROM centos/tools

COPY setup /root/
RUN /root/script.sh
