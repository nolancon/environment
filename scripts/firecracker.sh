#!/bin/bash

cd $GOPATH/src/github.com/
mkdir firecracker-microvm
git clone https://github.com/firecracker-microvm/firecracker
cd firecracker
y | tools/devtool build
toolchain="$(uname -m)-unknown-linux-musl"
cd ~
