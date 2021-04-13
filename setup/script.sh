#!/bin/bash

. ~/go-dev-env.conf

# yum dependencies
yum_deps()
{
  yum update -y
  yum install -y git wget make gcc glibc-devel dnf-plugins-core yum-utils curl
  yum config-manager -y --set-enabled powertools
}

# add git user and email configuration
git_config()
{
  git config --global user.name "$git_user"
  git config --global user.email "$git_email" 
}  

# setup go environment and install binaries
go_setup()
{
  gover=$go_version	 
  wget -c https://golang.org/dl/go${gover}.linux-amd64.tar.gz
  tar -C /usr/local -xvzf go${gover}.linux-amd64.tar.gz
  mkdir -p /root/go_projects/{bin,src,pkg}
  export PATH="$PATH:/usr/local/go/bin"
  export GOPATH="/root/go_projects"
  export GOBIN="/root/go_projects/bin"
}

# update vim to version compatible with vundle and vim-go
vim_update()
{
  vimversion="v$vim_version"	
  cd $GOPATH/src
  mkdir -p github.com/vim
  cd github.com/vim
  git clone --branch ${vimversion} https://github.com/vim/vim.git
  yum-builddep -y vim 
  cd vim
  ./configure
  make
  make install
  yes | cp -f /usr/bin/vi /root/old_vi
  yes | cp -f /usr/local/bin/vim /usr/bin/vi 
  cd ~
}

# add vim-go plugin via vundle
# add vimrc file from repo
go_vim()
{
  rm -rf ~/.vim/bundle/Vundle.vim
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  rm -rf ~/.vimrc
  wget -c https://raw.githubusercontent.com/nolancon/go-dev-env/master/vimrc -O ~/.vimrc
  vi +PluginUpdate +PluginInstall +qall
}

# add bashrc file located in repo
bashrc_update()
{
  wget -c https://raw.githubusercontent.com/nolancon/go-dev-env/master/bashrc -O ~/bashrc
  yes | mv ~/bashrc ~/.bashrc
  source ~/.bashrc
}

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

osdk_install()
{
  osdk_version="v$operator_sdk_version"	
  cd $GOPATH/src/github.com
  mkdir operator-framework
  cd operator-framework
  git clone https://github.com/operator-framework/operator-sdk
  cd operator-sdk
  git checkout ${osdk_version}
  make install
  mv $GOPATH/bin/operator-sdk /usr/local/bin/operator-sdk
  cd ~
}

yum_deps
git_config
go_setup
vim_update
go_vim
docker_install
kubectl_install
osdk_install
bashrc_update
