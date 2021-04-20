FROM centos/tools

COPY scripts /root/
RUN /root/go-dev-env.sh
