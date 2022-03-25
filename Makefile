.PHONY: deploy build all


deploy:	
		sh scripts/deploy-docker.sh

local:
		mkdir -p /~/.go-dev-env
			cp scripts/* /root/.go-dev-env/
				/root/.go-dev-env/local.sh
				

build-docker:  
		docker build -f Dockerfile -t nolancon/go-dev-env:latest .

build-ignite:
		docker build -f Dockerfile.ignite -t nolancon/ignite-go-dev-env:latest .

git:
		scripts/go-dev-env.sh git_config

go:
		scripts/go-dev-env.sh go_setup

docker:		
		scripts/clis.sh docker_install

kubectl:	
		scripts/clis.sh kubectl_install

osdk:		
		scripts/go-dev-env.sh osdk_install

repos:
		scripts/go-dev-env.sh clone_repos	

krew:
		scripts/go-dev-env.sh krew_install	

all: 	build-docker deploy-docker 
