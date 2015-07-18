all: test

build:
	@./node_modules/.bin/pegjs lib/yantl.pegjs lib/yantl.js

test: build
	@./node_modules/.bin/mocha -r should

.PHONY: all test build