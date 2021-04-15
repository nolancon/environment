![build](https://github.com/nolancon/go-dev-env/actions/workflows/docker.yml/badge.svg)
![build](https://github.com/nolancon/go-dev-env/actions/workflows/static-analysis.yml/badge.svg)

# Go Development Environment 💻
Go development environment provided in a `centos/tools` container:
* `go` environment configured with desired version
* `git` configured with user credentials
* `vim` updated to desired version (8.1 by default - compatible with vim-go)
* `vim-go` plugin enabled for Vim (edit utils/vimrc for other plugins)
* `docker` desired version installed (CLI only)
   * CLI is installed and connects to host Docker daemon. Therefore containers created from within go-dev-env container become sibling containers and not child containers.
* `kubectl` desired version installed
   * `~/.kube` directory is mounted from the host to the `go-dev-env` container, therefore `kubectl` commands from within the container interact with the host's K8s API.
* `operator-sdk` desired version installed
* `.bashrc` applied (edit utils/bashrc to customise and add aliases etc)

## Prerequisites
Just Docker

## Setup
* Edit [setup/go-dev-env.conf](https://github.com/nolancon/go-dev-env/blob/master/setup/go-dev-env.conf) with desired parameters. 

  **IMPORTANT**: Set correct git credentials
* Build image locally: `make image`
* Deploy container: `make deploy`
* Build + Deploy: `make all`
