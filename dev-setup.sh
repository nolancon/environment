#!/bin/bash

yum_deps()
{
  yum update -y
  yum install -y git wget make gcc glibc-devel dnf-plugins-core yum-utils 	
  yum config-manager  --set-enabled PowerTools
}

git_config()
{
  git config --global user.name "nolancon"
  git config --global user.email conor.nolan@intel.com
}  

go_setup()
{	
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

vim_update()
{
  cd $GOPATH/src
  mkdir -p github.com/vim
  cd github.com/vim
  git clone --branch v8.1.2269 https://github.com/vim/vim.git
  yum-builddep vim 
  cd vim
  ./configure
  make
  make install
  yes | cp -f /usr/bin/vi /root/old_vi
  yes | cp -f /usr/local/bin/vim /usr/bin/vi 
  cd ~
}

go_vim()
{
  rm -rf ~/.vim/bundle/Vundle.vim
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  rm -rf ~/.vimrc
  wget -c https://raw.githubusercontent.com/nolancon/environment/master/vimrc -O ~/.vimrc
  vi +PluginUpdate +PluginInstall +qall
}

bashrc_update()
{
  wget -c https://raw.githubusercontent.com/nolancon/environment/master/bashrc -O ~/.bashrc
  source ~/.bashrc
}

yum_deps
git_config
go_setup
vim_update
go_vim
bashrc_update
