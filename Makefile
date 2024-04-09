SHELL = /bin/bash # requires bash

.PHONY: drm

.DEFAULT_GOAL := help

help:
	@echo "Make options to build Dell Repository Manager container image"
	@echo
	@grep -E '^[a-zA-Z][^:]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'

drm: ## Create Dell Repository Manager image
ifndef REGISTRY
	$(eval REGISTRY="")
endif
	docker build --rm=true --pull -t $(REGISTRY)/$@:3.4.4 -f Dockerfile .
