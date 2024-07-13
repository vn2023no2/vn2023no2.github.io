.PHONY: build test

SHELL:=/bin/bash

build:
	docker run --rm -v npm-repo:/root/.npm -v "${PWD}":/app -w /app node:21.4-alpine3.19 npm install && npm run build 
test:
	docker compose up -d
