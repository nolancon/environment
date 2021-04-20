.PHONY: deploy build all

deploy:	
		sh scripts/deploy.sh

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


all: 	build deploy 
