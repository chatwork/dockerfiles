.PHONY: build
build:
	docker build -t chatwork/kubectl .;
	@version=$$(docker inspect -f {{.Config.Labels.version}} chatwork/kubectl); \
		if [ -n "$$version" ]; then \
			docker tag chatwork/kubectl:latest chatwork/kubectl:$$version; \
		fi

.PHONY: check
check:
	@version=$$(docker inspect -f {{.Config.Labels.version}} chatwork/kubectl); \
		if [ -z "$$version" ]; then \
			echo "\033[91mError: version is not defined in Dockerfile.\033[0m"; \
			exit 1; \
		fi;
	@echo "\033[92mno problem.\033[0m";

.PHONY: test
test:
	docker-compose -f docker-compose.test.yml up --no-start sut
	docker cp $(shell pwd)/goss kubectl114:/goss
	docker-compose -f docker-compose.test.yml up --no-recreate sut

.PHONY: push
push:
	@version=$$(docker inspect -f {{.Config.Labels.version}} chatwork/kubectl); \
		if docker inspect --format='{{index .RepoDigests 0}}' chatwork/kubectl:$$version >/dev/null 2>&1; then \
			echo "no changes"; \
		else \
			docker push chatwork/kubectl:latest; \
			docker tag chatwork/kubectl chatwork/kubectl:$$version; \
			docker push chatwork/kubectl:$$version; \
		fi
