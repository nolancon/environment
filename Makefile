.PHONY: deploy build all

deploy:	
		sh deploy.sh

build:  
		docker build -t nolancon/go-dev-env:latest .

git:
		setup/script.sh git_config

go:
		setup/script.sh go_setup

docker:		
		setup/script.sh docker_install

kubectl:	
		setup/script.sh kubectl_install

osdk:		
		setup/script.sh osdk_install


all: 	build deploy 
