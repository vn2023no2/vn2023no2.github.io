.PHONY: build test

SHELL:=/bin/bash

build:
	docker run --rm -v npm-repo:/root/.npm -v "${PWD}":/app -w /app node:21.4-alpine3.19 npm install && npm run build 

test:
	docker compose up -d

deploy:
	GIT_USER=vn2023no2 GIT_PASS=fhsidfhsklfjsadlfhsdfsjkladf DEPLOYMENT_BRANCH=gh-pages yarn deploy
