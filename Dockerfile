FROM centos/tools

COPY scripts /root/.go-dev-env
RUN /root/.go-dev-env/go-dev-env.sh
