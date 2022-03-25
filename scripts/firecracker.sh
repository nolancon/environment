#!/bin/bash

cd /home/nolancon/go_projects/src/github.com/
mkdir -p firecracker-microvm
git clone https://github.com/firecracker-microvm/firecracker
cd firecracker
yes y | tools/devtool build
toolchain="$(uname -m)-unknown-linux-musl"
cd ~
