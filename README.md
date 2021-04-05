# go-dev-env
Go development environment in Centos container:
* Setup Go
* Install + configure Git
* Update Vim version
* Enable `vim-go` plugin for Vim
* Install Docker CLI
* Update `.bashrc`

**Note:** Docker CLI is installed and connects to host Docker daemon. Therefore containers created from within go-dev-env container become sibling containers and not child containers.

## Setup
* Edit `setup/go-dev-env.conf` with desired parameters
* Build image: `make image`
* Deploy container: `make deploy`
* Build + Deploy: `make all`
