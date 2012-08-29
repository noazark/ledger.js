test:
	@./node_modules/.bin/mocha --compilers coffee:coffee-script --recursive --reporter spec

.PHONY: test