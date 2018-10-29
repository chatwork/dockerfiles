.PHONY: build
build:
	@for version1 in `cat helmfile-versions | head -n 3`; do \
		helmfile_version=$$(echo $$version1 | tr -d "\n"); \
		for version2 in `cat helm-versions | head -n 3 `; do \
			helm_version=`echo "$$version2" | cut -d':' -f1 | tr -d "\n"`; \
			diff_version=`echo "$$version2" | cut -d':' -f2 | tr -d "\n"`; \
			for version3 in `cat kubectl-versions | head -n 3`; do \
				kubectl_version=$$(echo $$version3 | tr -d "\n"); \
				version="$$helmfile_version-$$helm_version-$$kubectl_version"; \
					echo "@@@ $$version @@@"; \
				if ! docker pull chatwork/`basename $$PWD`:$$version >/dev/null 2>&1; then \
					docker build -t chatwork/`basename $$PWD`:"$$version" --build-arg HELMFILE_VERSION="$$helmfile_version" --build-arg HELM_VERSION="$$helm_version" --build-arg HELM_DIFF_VERSION="$$diff_version" --build-arg KUBECTL_VERSION="$$kubectl_version" .; \
				fi \
			done \
		done \
	done
	@docker tag chatwork/`basename $$PWD`:`cat helmfile-versions | head -n 1`-`cat helm-versions | head -n 1 | cut -d':' -f1`-`cat kubectl-versions | head -n 1` chatwork/`basename $$PWD`:latest

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
	@version=$$(docker inspect -f {{.Config.Labels.version}} chatwork/`basename $$PWD`:latest); \
		if docker inspect --format='{{index .RepoDigests 0}}' chatwork/$$(basename $$PWD):$$version >/dev/null 2>&1; then \
			echo "no changes"; \
		else \
			docker push chatwork/`basename $$PWD`;
		fi
