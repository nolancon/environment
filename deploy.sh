#!/bin/bash

id=$(docker run -v /var/run/docker.sock:/var/run/docker.sock -d -t nolancon/go-dev-env)
docker exec -it $id bash
