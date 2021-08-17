IMAGE ?= chatwork/kafka-connect-mysql

.PHONY: build
build:
	docker build -t $(IMAGE) .;
	@version=$$(docker inspect -f {{.Config.Labels.version}} $(IMAGE)); \
		if [ -n "$$version" ]; then \
			docker tag $(IMAGE):latest $(IMAGE):$$version; \
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
	docker-compose -f docker-compose.test.yml up --build --no-start sut
	docker cp $(shell pwd)/goss `basename $$PWD`:/goss
	docker-compose -f docker-compose.test.yml up --no-recreate --exit-code-from sut sut

.PHONY: push
push:
	@version=$$(docker inspect -f {{.Config.Labels.version}} $(IMAGE):latest); \
		if docker inspect --format='{{index .RepoDigests 0}}' $(IMAGE):$$version >/dev/null 2>&1; then \
			echo "no changes"; \
		else \
			docker push $(IMAGE):latest; \
			docker push $(IMAGE):$$version; \
		fi
