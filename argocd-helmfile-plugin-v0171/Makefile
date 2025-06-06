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
IMAGE_NAME:=$(shell basename $$PWD | sed 's/-v.*$$//')

.PHONY: build
build:
	@docker buildx build -t chatwork/${IMAGE_NAME}:latest --platform linux/${PLATFORM} -f Dockerfile --load .; \
	version=$$(docker inspect -f {{.Config.Labels.version}} chatwork/${IMAGE_NAME}:latest); \
	if [ -n "$$version" ]; then \
		docker tag chatwork/${IMAGE_NAME}:latest chatwork/${IMAGE_NAME}:$$version; \
	fi

.PHONY: check
check:
	@version=$$(docker inspect -f {{.Config.Labels.version}} chatwork/${IMAGE_NAME}); \
		if [ -z "$$version" ]; then \
			echo "\033[91mError: version is not defined in Dockerfile.\033[0m"; \
			exit 1; \
		fi;
	@echo "\033[92mno problem.\033[0m";

.PHONY: test
test: build
	docker-compose -f docker-compose.test.yml up --no-start sut
	docker cp $(shell pwd)/goss ${IMAGE_NAME}:/goss
	docker-compose -f docker-compose.test.yml up --no-recreate --exit-code-from sut sut

.PHONY: push
push:
	@version=$$(docker inspect -f {{.Config.Labels.version}} chatwork/${IMAGE_NAME}:latest); \
		if docker inspect --format='{{index .RepoDigests 0}}' chatwork/${IMAGE_NAME}:$$version >/dev/null 2>&1; then \
			echo "no changes"; \
		else \
			docker buildx build -t chatwork/${IMAGE_NAME}:$$version --platform linux/amd64,linux/arm64 -f Dockerfile --push .; \
		fi
