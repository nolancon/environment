#!/bin/bash

id=$(docker run -v /var/run/docker.sock:/var/run/docker.sock -v /root/.kube:/root/.kube -d -t go-dev-env:latest)
docker exec -it $id bash
