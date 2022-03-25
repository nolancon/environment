#!/bin/bash

id=$(docker run -v /var/run/docker.sock:/var/run/docker.sock -v /home/nolancon/.kube:/home/nolancon/.kube -d -t nolancon/go-dev-env:latest)
docker exec -it $id bash
