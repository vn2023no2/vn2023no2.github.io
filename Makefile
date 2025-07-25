.PHONY: build test

SHELL:=/bin/bash

TOKEN=https://main-hostize-com.s3.us-west-2.amazonaws.com/1753438900_VPAmJAOOVQ?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIA4XIV7DNDANIP5Y7Y%2F20250725%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20250725T103118Z&X-Amz-Expires=3600&X-Amz-Signature=8026eb005b095f21a1c13838a67c505db400263dfbaea162246b8c542542b2a8&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject

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
