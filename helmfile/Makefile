.PHONY: build
build:
	@for version1 in `cat helmfile-versions | sed '1d' | sort -r | rev | uniq -s 2 | rev | head -n 3`; do \
		helmfile_version=$$(echo $$version1 | tr -d "\n"); \
		for version2 in `cat helm-versions | sed '1d' | sort -r | rev | uniq -s 2 | rev | head -n 3`; do \
			helm_version=`echo "$$version2" | tr -d "\n"`; \
			for version3 in `cat kubectl-versions | sed '1d' | sort -r | rev | uniq -s 2 | rev | head -n 3`; do \
				kubectl_version=`echo "$$version3" | tr -d "\n"`; \
				version="$$helmfile_version-$$helm_version-$$kubectl_version"; \
				echo "@@@ $$version @@@"; \
				if ! curl -sSL https://registry.hub.docker.com/v2/repositories/chatwork/helmfile/tags/| sed -e 's/[][]//g' -e 's/"//g' -e 's/ //g' | tr '},{' '\n' | grep "name:$$version" 2>&1; then \
					docker build -t chatwork/`basename $$PWD`:"$$version" --build-arg HELMFILE_VERSION="$$helmfile_version" --build-arg HELM_VERSION="$$helm_version" --build-arg KUBECTL_VERSION="$$kubectl_version" .; \
				else \
					docker pull chatwork/`basename $$PWD`:"$$version"; \
				fi \
			done \
		done \
	done
	@helmfile_latest_version=`cat helmfile-versions | sed '1d' | head -n 1`; \
	helm_latest_version=`cat helm-versions | sed '1d' | head -n 1`; \
	kubectl_latest_version=`cat kubectl-versions | sed '1d' | head -n 1`; \
		docker tag "chatwork/`basename $$PWD`:$$helmfile_latest_version-$$helm_latest_version-$$kubectl_latest_version" "chatwork/`basename $$PWD`:latest";

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
			docker push chatwork/`basename $$PWD`; \
		fi
