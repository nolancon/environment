.PHONY: deploy build all

deploy:	
		sh deploy.sh

build:  
		docker build -t nolancon/go-dev-env:latest .

all: 	build deploy 
