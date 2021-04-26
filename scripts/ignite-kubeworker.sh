#!/bin/bash

# install kubernetes
yum install -y git gcc numactl

cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
exclude=kube*
EOF

setenforce 0

sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config

swapoff -a

cat <<EOF
> /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF

echo '1' > /proc/sys/net/bridge/bridge-nf-call-iptables
sysctl --system

yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes


# install iptables v1.4.21
yum install -y make kernel-devel autoconf automake libtool
mkdir -p ~/git-tmp
cd ~/git-tmp
git clone git://git.netfilter.org/iptables.git
cd iptables
git checkout v1.4.21
./autogen.sh

./configure --prefix=/usr --sbindir=/sbin --disable-nftables --enable-libipq --with-xtlibdir=/lib/xtables --disable-dependency-tracking
make
make install
cd ~

# install docker
yum install -y yum-utils

yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

yum install -y docker-ce docker-ce-cli containerd.io
