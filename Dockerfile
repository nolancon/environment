FROM centos

COPY setup /root/
RUN /root/script.sh
