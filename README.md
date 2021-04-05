# go-dev-env
Go development environment:
* Setup Go
* Install + configure Git
* Update Vim version
* Enable `vim-go` plugin for Vim
* Update `.bashrc`

## Run as Container
Centos 8 base image with Git, Go and Vim-Go configured.
* Edit `setup/go-dev-env.conf` with desired parameters
* `docker build -t <container-name:tag> .`

## Run standalone script on BM or VM
* Edit `setup/go-dev-env.conf` with desired parameters
* `source setup/script.sh`
