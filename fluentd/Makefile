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
	@docker buildx build -t chatwork/`basename $$PWD`:latest --platform linux/${PLATFORM} -f Dockerfile --load .;
	@version=$$(docker inspect -f {{.Config.Labels.version}} chatwork/`basename $$PWD`); \
		if [ -n "$$version" ]; then \
			docker tag chatwork/`basename $$PWD`:latest chatwork/`basename $$PWD`:$$version; \
		fi

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
			docker push chatwork/`basename $$PWD`:latest; \
			docker push chatwork/`basename $$PWD`:$$version; \
		fi
