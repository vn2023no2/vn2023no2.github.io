.PHONY: build test

SHELL:=/bin/bash

TOKEN=123456789

create:
	docker run --rm -v npm-repo:/root/.npm -v "${PWD}":/app -w /app node:21.4-alpine3.19 npm init docusaurus 

build:
	docker run --rm -v npm-repo:/root/.npm -v "${PWD}":/app -w /app node:21.4-alpine3.19 npm install && npm run build 

test:
	docker compose up -d

deploy:
	GIT_USER=vn2023no2 GIT_PASS=${TOKEN} DEPLOYMENT_BRANCH=gh-pages yarn deploy

push:
	git push https://vn2023no2:${TOKEN}@github.com/vn2023no2/vn2023no2.github.io
