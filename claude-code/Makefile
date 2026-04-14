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
IMAGE_NAME:=claude-code

.PHONY: build
build:
	@docker buildx build -t chatwork/${IMAGE_NAME}:latest --platform linux/${PLATFORM} -f Dockerfile --load .; \
	version=$$(docker inspect -f {{.Config.Labels.version}} chatwork/${IMAGE_NAME}:latest); \
	if [ -n "$$version" ]; then \
		docker tag chatwork/${IMAGE_NAME}:latest chatwork/${IMAGE_NAME}:$$version; \
	fi

.PHONY: test
test: build
	docker-compose -f docker-compose.test.yml up --no-start sut
	docker cp $(shell pwd)/goss ${IMAGE_NAME}:/goss
	docker-compose -f docker-compose.test.yml up --no-recreate --exit-code-from sut sut

.PHONY: push
push:
	@version=$$(docker inspect -f {{.Config.Labels.version}} chatwork/${IMAGE_NAME}:latest); \
		if docker inspect --format='{{index .RepoDigests 0}}' chatwork/${IMAGE_NAME}:$$version-$(TAG) >/dev/null 2>&1; then \
			echo "no changes"; \
		else \
			docker buildx build -t chatwork/${IMAGE_NAME}:$$version-$(TAG) --platform linux/${PLATFORM} -f Dockerfile --push .; \
		fi

.PHONY: manifest\:push
manifest\:push:
	@version=$$(docker inspect -f {{.Config.Labels.version}} chatwork/${IMAGE_NAME}:latest); \
		if docker inspect --format='{{index .RepoDigests 0}}' chatwork/${IMAGE_NAME}:$$version >/dev/null 2>&1; then \
			echo "no changes"; \
		else \
			docker pull chatwork/${IMAGE_NAME}:$$version-aarch64; \
			docker pull chatwork/${IMAGE_NAME}:$$version-x86_64; \
			arm64_digest=$$(docker inspect -f '{{index .RepoDigests 0}}' chatwork/${IMAGE_NAME}:$$version-aarch64); \
			amd64_digest=$$(docker inspect -f '{{index .RepoDigests 0}}' chatwork/${IMAGE_NAME}:$$version-x86_64); \
			docker buildx imagetools create -t chatwork/${IMAGE_NAME}:$$version $$arm64_digest $$amd64_digest; \
			docker buildx imagetools create -t chatwork/${IMAGE_NAME}:latest $$arm64_digest $$amd64_digest; \
			hub-tool tag rm chatwork/${IMAGE_NAME}:$$version-aarch64 -f; \
			hub-tool tag rm chatwork/${IMAGE_NAME}:$$version-x86_64 -f; \
		fi

.PHONY: manifest\:succeed-message
manifest\:succeed-message:
	@version=$$(docker inspect -f {{.Config.Labels.version}} chatwork/${IMAGE_NAME}:latest); \
		echo "Released new tags."; \
		echo "- chatwork/${IMAGE_NAME}:$$version"; \
		echo "- chatwork/${IMAGE_NAME}:latest"
