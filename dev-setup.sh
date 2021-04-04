#!/bin/bash

update_git()
{
  git version
  if [ $? -eq 0 ]; then
     echo OK
  else
     echo "git not present, installing git..."
     yum install  -y git
  fi
  git config --global user.name "nolancon"
  git config --global user.email conor.nolan@intel.com
}  

setup_go()
{	
  yum install -y wget
  wget -c https://golang.org/dl/go1.15.2.linux-amd64.tar.gz
  tar -C /usr/local -xvzf go1.15.2.linux-amd64.tar.gz
  mkdir -p /root/go_projects/{bin,src,pkg}
  export PATH="$PATH:/usr/local/go/bin"
  export GOPATH="/root/go_projects"
  export GOBIN="/root/go_projects/bin"
  go version
  if [ $? eq 0 ]; then
     echo "failed to setup go"
  fi
} 

go_vim()
{
  rm -rf ~/.vim/bundle/Vundle.vim
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
#  rm -rf ~/.vimrc
  wget -c https://raw.githubusercontent.com/nolancon/environment/master/vimrc -O ~/.vimrc
  echo RUNVI
  vi +PluginUpdate +PluginInstall +qall
}

update_vim()
{
  yum install -y make gcc glibc-devel	 
  cd $GOPATH/src/github.com
#  mkdir vim && cd vim
#  git clone --branch v8.1.2269 https://github.com/vim/vim.git
  cd vim/vim
  #export CFLAGS="-DCOMPILER_FLAG ./configure --enable-gui=motif"
  ./configure CFLAGS="-O3"
  echo CONFIG
  make
  make install
  cd /
}

#update_git 
#setup_go
update_vim
#go_vim
