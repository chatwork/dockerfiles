ARCH:=$(shell uname -m)
PLATFORM:=$(shell case "$(ARCH)" in \
	("arm64"|"aarch64") echo "arm64" ;; \
	("x86_64") echo "amd64" ;; \
	(*) echo $(ARCH) ;; \
esac)

ARM64_SUFFIX:=aarch64
AMD64_SUFFIX:=x86_64
SUFFIX:=$(shell case "$(ARCH)" in \
	("arm64"|"aarch64") echo "$(ARM64_SUFFIX)" ;; \
	("x86_64") echo "$(AMD64_SUFFIX)" ;; \
	(*) echo $(ARCH) ;; \
esac)

# $(call image_ref,version,suffix) -> chatwork/claude-code:<version>[-<suffix>]
image_ref=chatwork/claude-code:$(1)$(if $(2),-$(2))

.PHONY: build
build:
	@docker buildx build -t $(call image_ref,latest) --platform linux/${PLATFORM} -f Dockerfile --load .; \
	version=$$(docker inspect -f {{.Config.Labels.version}} $(call image_ref,latest)); \
	if [ -n "$$version" ]; then \
		docker tag $(call image_ref,latest) $(call image_ref,$$version); \
	fi

.PHONY: test
test: build
	docker-compose -f docker-compose.test.yml up --no-start sut
	docker cp $(shell pwd)/goss claude-code:/goss
	docker-compose -f docker-compose.test.yml up --no-recreate --exit-code-from sut sut

.PHONY: push
push:
	@version=$$(docker inspect -f {{.Config.Labels.version}} $(call image_ref,latest)); \
		if docker inspect --format='{{index .RepoDigests 0}}' $(call image_ref,$$version,$(SUFFIX)) >/dev/null 2>&1; then \
			echo "no changes"; \
		else \
			docker buildx build -t $(call image_ref,$$version,$(SUFFIX)) --platform linux/${PLATFORM} -f Dockerfile --push .; \
		fi

.PHONY: manifest\:push
manifest\:push:
	@version=$$(docker inspect -f {{.Config.Labels.version}} $(call image_ref,latest)); \
		if docker inspect --format='{{index .RepoDigests 0}}' $(call image_ref,$$version) >/dev/null 2>&1; then \
			echo "no changes"; \
		else \
			docker pull $(call image_ref,$$version,$(ARM64_SUFFIX)); \
			docker pull $(call image_ref,$$version,$(AMD64_SUFFIX)); \
			arm64_digest=$$(docker inspect -f '{{index .RepoDigests 0}}' $(call image_ref,$$version,$(ARM64_SUFFIX))); \
			amd64_digest=$$(docker inspect -f '{{index .RepoDigests 0}}' $(call image_ref,$$version,$(AMD64_SUFFIX))); \
			docker buildx imagetools create -t $(call image_ref,$$version) $$arm64_digest $$amd64_digest; \
			docker buildx imagetools create -t $(call image_ref,latest) $$arm64_digest $$amd64_digest; \
			hub-tool tag rm $(call image_ref,$$version,$(ARM64_SUFFIX)) -f; \
			hub-tool tag rm $(call image_ref,$$version,$(AMD64_SUFFIX)) -f; \
		fi

.PHONY: manifest\:succeed-message
manifest\:succeed-message:
	@version=$$(docker inspect -f {{.Config.Labels.version}} $(call image_ref,latest)); \
		echo "Released new tags."; \
		echo "- $(call image_ref,$$version)"; \
		echo "- $(call image_ref,latest)"
