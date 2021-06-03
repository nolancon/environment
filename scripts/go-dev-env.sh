#!/bin/bash

. /root/.go-dev-env/go-dev-env.conf

# apt dependencies
apt_deps()
{
  apt update -y
  apt install -y git wget make curl
}

# add git user and email configuration
git_config()
{
  git config --global user.name "$git_user"
  git config --global user.email "$git_email"
  echo "Git configured with username: $git_user and email: $git_email" 
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

# add vim-go plugin via vundle
# add vimrc file from repo
go_vim()
{
  rm -rf /root/.vim/bundle/Vundle.vim
  git clone https://github.com/VundleVim/Vundle.vim.git /root/.vim/bundle/Vundle.vim
  rm -rf /root/.vimrc
  wget -c https://raw.githubusercontent.com/nolancon/go-dev-env/master/utils/vimrc -O /root/.vimrc
}

# add bashrc file located in repo
bashrc_update()
{
  wget -c https://raw.githubusercontent.com/nolancon/go-dev-env/master/utils/bashrc -O /root/bashrc
  yes | mv /root/bashrc /root/.bashrc
  sudo source /root/.bashrc
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
  cd /root
}

clone_repos()
{
  mkdir -p $GOPATH/src/github.com		
  repos=$(echo $github_repos | tr "," "\n")
  for repo in $repos
  do
    cd $GOPATH/src/github.com
    user=$(echo $repo | cut -d'/' -f1)
    mkdir -p $user
    cd $user
    git clone https://github.com/$repo
  done
  cd /root  
}

case "$1" in
  "") ;;
  git_config) "$@"; exit;;
  go_setup) "$@"; exit;;
  osdk_install) "$@"; exit;;
  clone_repos) "$@"; exit;;

  *) echo "Unkown function: $1()"; exit 2;;
esac

apt_deps
git_config
go_setup
bashrc_update
go_vim
clone_repos
osdk_install
