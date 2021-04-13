.PHONY: deploy build all

deploy:	
		sh deploy.sh

build:  
		docker build -t go-dev-env:latest .

all: 	build deploy 
