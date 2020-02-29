.DEFAULT_GOAL := api-docs

init:
ifndef path
	err = $(error path is undefined)
	$(err)
endif
	mkdir -p .build
	cp $(path) .build/

api-docs: init
	# generate sdk
	docker run --rm -v ${PWD}/.build:/build sourcey/spectacle \
		spectacle /build/api.swagger.json -t /build/
	rm .build/api.swagger.json
	
	# Update repository files with generated files
	cp -r .build/* .