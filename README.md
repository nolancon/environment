# go-dev-env
Go development environment in a `centos/tools` container:
* Setup Go
* Install + configure Git
* Update Vim version
* Enable `vim-go` plugin for Vim
* Install `docker` (CLI only)
* Install `kubectl`
* Install `operator-sdk`
* Update `.bashrc`

**Notes:** 
* Docker CLI is installed and connects to host Docker daemon. Therefore containers created from within go-dev-env container become sibling containers and not child containers.
* Kubectl is installed and the `~/.kube` directory is mounted from the host to the `go-dev-env` container.

## Setup
* Edit `setup/go-dev-env.conf` with desired parameters
* Build image: `make image`
* Deploy container: `make deploy`
* Build + Deploy: `make all`
