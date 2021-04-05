#!/bin/bash

. ~/go-dev-env.conf

yum_deps()
{
  yum update -y
  yum install -y git wget make gcc glibc-devel dnf-plugins-core yum-utils 	
  yum config-manager -y --set-enabled powertools
}

git_config()
{
  git config --global user.name "$git_user"
  git config --global user.email "$git_email" 
}  

go_setup()
{
  gover=$go_version	 
  wget -c https://golang.org/dl/go${gover}.linux-amd64.tar.gz
  tar -C /usr/local -xvzf go${gover}.linux-amd64.tar.gz
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

go_vim()
{
  rm -rf ~/.vim/bundle/Vundle.vim
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  rm -rf ~/.vimrc
  wget -c https://raw.githubusercontent.com/nolancon/go-dev-env/master/vimrc -O ~/.vimrc
  vi +PluginUpdate +PluginInstall +qall
}

bashrc_update()
{
  wget -c https://raw.githubusercontent.com/nolancon/go-dev-env/master/bashrc -O ~/bashrc
  yes | mv ~/bashrc ~/.bashrc
  source ~/.bashrc
}

yum_deps
git_config
go_setup
vim_update
go_vim
bashrc_update
