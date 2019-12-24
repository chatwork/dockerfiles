KFO_VERSION ?= v1.11.0
REPOSITORY ?= chatwork
IMAGE ?= $(REPOSITORY)/$(shell basename $$PWD)
TAG ?= latest

.PHONY: build
build: clone
	docker build -t $(IMAGE) .;
		make clean
		@version=$$(docker inspect -f {{.Config.Labels.version}} chatwork/`basename $$PWD`); \
		if [ -n "$$version" ]; then \
			docker tag chatwork/`basename $$PWD`:latest chatwork/`basename $$PWD`:$$version; \
		fi

.PHONY: check
check:
	@version=$$(docker inspect -f {{.Config.Labels.version}} $(IMAGE)); \
		if [ -z "$$version" ]; then \
			echo "\033[91mError: version is not defined in Dockerfile.\033[0m"; \
			exit 1; \
		fi;
	@echo "\033[92mno problem.\033[0m";

.PHONY: test
test:
	docker-compose -f docker-compose.test.yml up --no-start sut
	docker cp $(shell pwd)/goss `basename $$PWD`:/goss
	docker-compose -f docker-compose.test.yml up --no-recreate sut

.PHONY: push
push:
	@version=$$(docker inspect -f {{.Config.Labels.version}} $(IMAGE)); \
		if docker inspect --format='{{index .RepoDigests 0}}' $(IMAGE):$$version >/dev/null 2>&1; then \
			echo "no changes"; \
		else \
			docker push $(IMAGE):latest; \
			docker tag $(IMAGE):latest $(IMAGE):$$version; \
			docker push $(IMAGE):$$version; \
		fi

.PHONY: clone
clone: clean
	git clone --depth=1 -b $(KFO_VERSION) https://github.com/vmware/kube-fluentd-operator.git

.PHONY: clean
clean:
	/bin/rm -fr kube-fluentd-operator

shell:
	docker run --entrypoint=/bin/bash \
	  -ti --rm -v `pwd`:/workspace --net=host \
	  $(IMAGE):$(TAG)
