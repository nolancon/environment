#!/bin/bash

CNI_VERSION=v0.9.1
ARCH=$([ $(uname -m) = "x86_64" ] && echo amd64 || echo arm64)

IGNITE_VERSION=v0.9.0
GOARCH=$(go env GOARCH 2>/dev/null || echo "amd64")

yum install -y e2fsprogs openssh-clients git

which containerd || ( yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo && yum install -y containerd.io )

sudo mkdir -p /opt/cni/bin
curl -sSL https://github.com/containernetworking/plugins/releases/download/${CNI_VERSION}/cni-plugins-linux-${ARCH}-${CNI_VERSION}.tgz | sudo tar -xz -C /opt/cni/bin

for binary in ignite ignited; do
    echo "Installing ${binary}..."
    curl -sfLo ${binary} https://github.com/weaveworks/ignite/releases/download/${IGNITE_VERSION}/${binary}-${GOARCH}
    chmod +x ${binary}
    sudo mv ${binary} /usr/local/bin
done
