ARCH:=$(shell uname -m)
TAG:=$(shell case "$(ARCH)" in \
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
	$(shell find . -type f -name "Dockerfile${EXTENSION}" | while read -r FILE; do \
  		docker build -f $$FILE -t chatwork/`basename $$PWD` .; \
  		version=$$(docker inspect -f {{.Config.Labels.version}} chatwork/`basename $$PWD`); \
  		if [ -n "$$version" ]; then \
          docker tag chatwork/`basename $$PWD`:latest chatwork/`basename $$PWD`:$$version-${TAG}; \
        fi \
	done)

.PHONY: check
check:
	@version=$$(docker inspect -f {{.Config.Labels.version}} chatwork/`basename $$PWD`); \
		if [ -z "$$version" ]; then \
			echo "\033[91mError: version is not defined in Dockerfile.\033[0m"; \
			exit 1; \
		fi;
	@echo "\033[92mno problem.\033[0m";

.PHONY: test
test:
	docker-compose -f docker-compose.test.yml up --build --no-start sut
	docker cp $(shell pwd)/goss `basename $$PWD`:/goss
	docker-compose -f docker-compose.test.yml up --no-recreate --exit-code-from sut sut

.PHONY: push
push:
	@version=$$(docker inspect -f {{.Config.Labels.version}} chatwork/`basename $$PWD`:latest); \
		if docker inspect --format='{{index .RepoDigests 0}}' chatwork/$$(basename $$PWD):$$version >/dev/null 2>&1; then \
			echo "no changes"; \
		else \
			docker push chatwork/`basename $$PWD`:$$version-${TAG}; \
		fi

.PHONY: manifest
manifest:
	make push
	@version=$$(docker inspect -f {{.Config.Labels.version}} chatwork/`basename $$PWD`:latest); \
		if docker inspect --format='{{index .RepoDigests 0}}' chatwork/$$(basename $$PWD):$$version-${TAG} >/dev/null 2>&1; then \
			echo "no changes"; \
		else \
			docker manifest create chatwork/`basename $$PWD`:$$version \
            	chatwork/`basename $$PWD`:$$version-arm64 \
            	chatwork/`basename $$PWD`:$$version-amd64; \
            docker manifest push chatwork/`basename $$PWD`:$$version; \

			docker manifest create chatwork/`basename $$PWD` \
            	chatwork/`basename $$PWD`:$$version-arm64 \
            	chatwork/`basename $$PWD`:$$version-amd64; \
            docker push chatwork/`basename $$PWD`; \
		fi



