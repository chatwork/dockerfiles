.PHONY: build
build:
	docker build -t chatwork/`basename $$PWD` .;

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
	@make check;
	docker-compose -f docker-compose.test.yml run --rm sut;

.PHONY: push
push:
	@version=$$(docker inspect -f {{.Config.Labels.version}} chatwork/`basename $$PWD`); \
		if docker inspect --format='{{index .RepoDigests 0}}' chatwork/$$(basename $$PWD):$$version >/dev/null 2>&1; then \
			echo "no changes"; \
		else \
			docker push chatwork/`basename $$PWD`:latest; \
			docker tag chatwork/`basename $$PWD` chatwork/`basename $$PWD`:$$version; \
			docker push chatwork/`basename $$PWD`:$$version; \
		fi
