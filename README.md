![build](https://github.com/nolancon/go-dev-env/actions/workflows/docker.yml/badge.svg)
![build](https://github.com/nolancon/go-dev-env/actions/workflows/static-analysis.yml/badge.svg)

# Go Development Environment 🚀
Go development environment configured on host, in a `centos/tools` container or in an `weaveworks/ignite-centos` MicroVM image.

## Setup
Edit `[scripts/go-dev-env.conf](https://github.com/nolancon/go-dev-env/blob/master/scripts/go-dev-env.conf)` with desired parameters before executing any of the options below. 

**IMPORTANT**: Set correct git credentials  
  
## Host (Bare Metal or VM) 💻

Run `make local` to configure your environment with the following (suitable for Bare Metal or VM):

* `go` environment configured with desired version
* `git` configured with user credentials
* `vim` updated to desired version (8.1 by default - compatible with vim-go)
* `vim-go` plugin enabled for Vim (edit utils/vimrc for other plugins)
* `docker` desired version installed
* `kubectl` desired version installed
* `operator-sdk` desired version installed
* `.bashrc` applied (edit utils/bashrc to customise and add aliases etc)
* Github repos specified in `go-dev-env.conf` cloned locally to `GOPATH`
* `firecracker` installed
* `ignite` installed

## Docker Container 🧰 or Ignite MicroVM 🔥

Run `make build-docker` to build a `centos/tools` docker image with the following:
Run `make build-docker` to build a `weaveworks/ignite-centos` MicroVM image with the following:

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
* Github repos specified in `go-dev-env.conf` cloned locally to `GOPATH`

### Deploy Docker Container

`make deploy`

### Deploy Ignite MicroVM

Note the image is >4GB so 6GB micro VM is created to facilitate 

```
ignite run nolancon/ignite-go-dev-env \
  --name my-vm \
  --cpus 2 \
  --memory 1GB \
  --size 6GB \
  --ssh
```
