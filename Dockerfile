FROM centos

COPY setup /root/
RUN /root/dev-setup.sh
