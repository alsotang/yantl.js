all: test

build:
	@./node_modules/.bin/pegjs lib/yantl.pegjs lib/yantl.js

test: build
	@./node_modules/.bin/mocha -r should

publish:
	npm publish
	git push origin master

.PHONY: all test build