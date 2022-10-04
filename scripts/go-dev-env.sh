#!/bin/bash

. /root/.go-dev-env/go-dev-env.conf

# apt dependencies
apt_deps()
{
  apt update -y
  apt install -y git wget make curl gcc libdevmapper-dev pkg-config
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

# install desired vim version (via go-dev-env.conf)
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

kind_install()
{
  curl -Lo /usr/local/bin/kind https://kind.sigs.k8s.io/dl/v${kind_version}/kind-linux-amd64
  chmod +x /usr/local/bin/kind
}

krew_install()
{
  set -x; cd "$(mktemp -d)" &&
  OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
  ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/krew.tar.gz" &&
  tar zxvf krew.tar.gz &&
  KREW=./krew-"${OS}_${ARCH}" &&
  "$KREW" install krew
}

kuttl_install()
{
  curl -Lo /usr/local/bin/kubectl-kuttl https://github.com/kudobuilder/kuttl/releases/download/v${kuttl_version}/kubectl-kuttl_${kuttl_version}_linux_x86_64
  chmod +x /usr/local/bin/kubectl-kuttl
}

clone_repos()
{
  mkdir -p $GOPATH/src/github.com
  mkdir -p $GOPATH/src/code.storageos.net
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
  krew_install) "$@"; exit;;
  kuttl_install) "$@"; exit;;
  kind_install) "$@"; exit;;

  *) echo "Unknown function: $1()"; exit 2;;
esac

apt_deps
git_config
go_setup
bashrc_update
vim_update
go_vim
kind_install
krew_install
kuttl_install
clone_repos
#osdk_install
