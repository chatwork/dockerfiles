ARCH=`uname -m`

.PHONY: build
build:
	docker build -t chatwork/`basename $$PWD` .;
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
			docker push chatwork/`basename $$PWD`; \
		fi

.PHONY: supported
supported:
	@if [ "`echo \"arm64\n aarch64\" | grep $(shell echo $(ARCH))`" ] ; then \
		exit 0; \
	else \
	  	echo "$(ARCH) is not supported." && exit 1; \
	fi
