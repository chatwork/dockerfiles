IMAGE ?= chatwork/kubectl
ARCH:=$(shell uname -m)
ARCHTAG:=$(shell case "$(ARCH)" in \
	("arm64"|"aarch64") echo "arm64" ;; \
	("x86_64") echo "x86_64" ;; \
	(*) echo $(ARCH) ;; \
esac)
EXTENSION:=$(shell case "$(ARCH)" in \
	("arm64"|"aarch64") echo ".arm64" ;; \
	("x86_64") echo "" ;; \
	(*) echo $(ARCH) ;; \
esac)

.PHONY: build
build:
	@find . -type f -name "Dockerfile${EXTENSION}" | while read -r FILE; do \
		docker build -f Dockerfile${EXTENSION} -t $(IMAGE) .; \
      	version=$$(docker inspect -f {{.Config.Labels.version}} $(IMAGE)); \
      	if [ -n "$$version" ]; then \
            docker tag $(IMAGE):latest $(IMAGE):$$version-${ARCHTAG}; \
        fi \
    done

.PHONY: check
check:
	@version=$$(docker inspect -f {{.Config.Labels.version}} $(IMAGE)); \
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
	@version=$$(docker inspect -f {{.Config.Labels.version}} $(IMAGE):latest); \
		if docker inspect --format='{{index .RepoDigests 0}}' $(IMAGE):$$version >/dev/null 2>&1; then \
			echo "no changes"; \
		else \
			docker buildx build -t $(IMAGE):$$version -t $(IMAGE) --platform linux/amd64,linux/arm64 --push .; \
		fi

.PHONY: manifest\:push
manifest\:push:
	@echo "Manifest push skipped, because this image use buildx."

.PHONY: manifest\:succeed-message
manifest\:succeed-message:
	@echo "Manifest push skipped, because this image use buildx."
