#!/bin/bash 

sudo apt install rsync

rsync -a /root/go_projects/src/code.storageos.net/projects/pre/kubecover root@$1:/root/go_projects/src/code.storageos.net/pre
