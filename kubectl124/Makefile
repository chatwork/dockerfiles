IMAGE ?= chatwork/kubectl
ARCH:=$(shell uname -m)
TAG:=$(shell case "$(ARCH)" in \
	("arm64"|"aarch64") echo "arm64" ;; \
	("x86_64") echo "x86_64" ;; \
	(*) echo $(ARCH) ;; \
esac)
PLATFORM:=$(shell case "$(ARCH)" in \
	("arm64"|"aarch64") echo "arm64" ;; \
	("x86_64") echo "amd64" ;; \
	(*) echo $(ARCH) ;; \
esac)

.PHONY: build
build:
	@docker buildx build -t $(IMAGE) --platform linux/${PLATFORM} -f Dockerfile --load .; \
	version=$$(docker inspect -f {{.Config.Labels.version}} $(IMAGE)); \
	if [ -n "$$version" ]; then \
		docker tag $(IMAGE):latest $(IMAGE):$$version-${ARCHTAG}; \
	fi

.PHONY: check
check:
	@version=$$(docker inspect -f {{.Config.Labels.version}} $(IMAGE) $$PWD`); \
		if [ -z "$$version" ]; then \
			echo "\033[91mError: version is not defined in Dockerfile.\033[0m"; \
			exit 1; \
		fi;
	@echo "\033[92mno problem.\033[0m";

.PHONY: test
test: build
	docker-compose -f docker-compose.test.yml up --no-start sut
	docker cp $(shell pwd)/goss `basename $$PWD`:/goss
	docker-compose -f docker-compose.test.yml up --no-recreate --exit-code-from sut sut

.PHONY: push
push:
	@version=$$(docker inspect -f {{.Config.Labels.version}} $(IMAGE) $$PWD:latest); \
		if docker inspect --format='{{index .RepoDigests 0}}' $(IMAGE):$$version >/dev/null 2>&1; then \
			echo "no changes"; \
		else \
			docker buildx build -t $(IMAGE):$$version --platform linux/amd64,linux/arm64 -f Dockerfile --push .; \
		fi
