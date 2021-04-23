.PHONY: deploy build all

deploy:	
		sh scripts/deploy.sh

local:
		mkdir ~/.go-dev-env
			cp scripts/* ~/.go-dev-env/
				~/.go-dev-env/go-dev-env.sh
				

build:  
		docker build -t nolancon/go-dev-env:latest .

git:
		scripts/go-dev-env.sh git_config

go:
		scripts/go-dev-env.sh go_setup

docker:		
		scripts/go-dev-env.sh docker_install

kubectl:	
		scripts/go-dev-env.sh kubectl_install

osdk:		
		scripts/go-dev-env.sh osdk_install

repos:
		scripts/go-dev-env.sh clone_repos	

all: 	build deploy 
