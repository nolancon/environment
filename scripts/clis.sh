#!/bin/bash

. /home/nolancon/.go-dev-env/go-dev-env.conf

# install docker cli only - to be connected to host docker daemon
docker_install()
{	
  curl -fsSLO https://download.docker.com/linux/static/stable/x86_64/docker-${docker_version}.tgz
  tar xzvf docker-${docker_version}.tgz --strip 1 -C /usr/local/bin docker/docker
  rm docker-${docker_version}.tgz  
}

kubectl_install()
{
  curl -LO https://storage.googleapis.com/kubernetes-release/release/v$kubectl_version/bin/linux/amd64/kubectl
  chmod +x ./kubectl
  mv ./kubectl /usr/local/bin/kubectl
}

case "$1" in
  "") ;;
  docker_install) "$@"; exit;;
  kubectl_install) "$@"; exit;;

  *) echo "Unkown function: $1()"; exit 2;;
esac

docker_install
kubectl_install
