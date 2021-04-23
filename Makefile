.PHONY: deploy build all

deploy:	
		sh scripts/deploy-docker.sh

local:
		mkdir -p ~/.go-dev-env
			cp scripts/* ~/.go-dev-env/
				~/.go-dev-env/local.sh
				

build-docker:  
		docker build -f Dockerfile -t nolancon/go-dev-env:latest .

build-ignite:
		docker build -f Dockerfile.ignite -t nolancon/ignite-go-dev-env:latest .

git:
		scripts/go-dev-env.sh git_config

go:
		scripts/go-dev-env.sh go_setup

docker:		
		scripts/cli.sh docker_install

kubectl:	
		scripts/cli.sh kubectl_install

osdk:		
		scripts/go-dev-env.sh osdk_install

repos:
		scripts/go-dev-env.sh clone_repos	

all: 	build-docker deploy-docker 
