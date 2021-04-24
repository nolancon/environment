![build](https://github.com/nolancon/go-dev-env/actions/workflows/docker.yml/badge.svg)
![build](https://github.com/nolancon/go-dev-env/actions/workflows/static-analysis.yml/badge.svg)

# Go Development Environment 💻
Go development environment configured on host, in a `centos/tools` container or in an `weaveworks/ignite-centos` MicroVM image.
* `go` environment configured with desired version
* `git` configured with user credentials
* `vim` updated to desired version (8.1 by default - compatible with vim-go)
* `vim-go` plugin enabled for Vim (edit utils/vimrc for other plugins)
* `docker` desired version installed (CLI only for container)
   * CLI is installed and connects to host Docker daemon. Therefore containers created from within go-dev-env container become sibling containers and not child containers.
* `kubectl` desired version installed
   * `~/.kube` directory is mounted from the host to the `go-dev-env` container, therefore `kubectl` commands from within the container interact with the host's K8s API.
* `operator-sdk` desired version installed
* `.bashrc` applied (edit utils/bashrc to customise and add aliases etc)
*  `firecracker` installed (only for local).
*  `ignite` installed (only for local).

## Setup
Edit [scripts/go-dev-env.conf](https://github.com/nolancon/go-dev-env/blob/master/scripts/go-dev-env.conf) with desired parameters. 

  **IMPORTANT**: Set correct git credentials

## Build

### Local BM/VM

Run script locally to configure environment. This should be used on the host machine as it installs and runs the Docker daemon.

`make local`

### Docker Container

`make deploy`

### Ignite Micro-VM

Note the image is >4GB so 6GB micro VM is created to facilitate 

```
ignite run nolancon/ignite-go-dev-env \
  --name my-vm \
  --cpus 2 \
  --memory 1GB \
  --size 6GB \
  --ssh
```
