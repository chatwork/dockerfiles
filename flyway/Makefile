ARCH:=$(shell uname -m)
ENV:="dev"
SCOPE_SUFFIX:=$(shell if [ $(ENV) = "prod" ]; then \
 	echo ""; \
 	else \
 		echo "-$(ENV)"; \
 	fi)
EXTENSION:=$(shell case "$(ARCH)" in \
	("arm64"|"aarch64") echo ".arm64" ;; \
	("x86_64") echo "" ;; \
	(*) echo $(ARCH) ;; \
esac)

.PHONY: build
build:
	@find . -type f -name "Dockerfile${EXTENSION}" | while read -r FILE; do \
		docker build -f Dockerfile -t chatwork/`basename $$PWD` .; \
      	version=$$(docker inspect -f {{.Config.Labels.version}} chatwork/`basename $$PWD`:latest); \
        flyway_version=$$(docker inspect -f {{.Config.Labels.version}} chatwork/`basename $$PWD`:latest); \
        mysql_version=$$(docker inspect -f {{.Config.Labels.mysql_version}} chatwork/`basename $$PWD`:latest); \
      	if [ -n "$$version" ] && [ -n "$$flyway_version" ] && [ -n "$$mysql_version" ]; then \
            docker tag chatwork/`basename $$PWD`:latest chatwork/`basename $$PWD`:$$version$(SCOPE_SUFFIX); \
        fi \
    done

.PHONY: check
check:
	@version=$$(docker inspect -f {{.Config.Labels.version}} chatwork/`basename $$PWD`:latest); \
    flyway_version=$$(docker inspect -f {{.Config.Labels.flyway_version}} chatwork/`basename $$PWD`:latest); \
    mysql_version=$$(docker inspect -f {{.Config.Labels.mysql_version}} chatwork/`basename $$PWD`:latest); \
    if [[ -z $$version ]]; then \
    	echo "\033[91mError: version is not defined in Dockerfile.\033[0m"; \
    	exit 1; \
    fi; \
    if [[ -z $$flyway_version ]]; then \
    	echo "\033[91mError: flyway_version is not defined in Dockerfile.\033[0m"; \
    	exit 1; \
    fi; \
    if [[ -z $$mysql_version ]]; then \
    	echo "\033[91mError: mysql_version is not defined in Dockerfile.\033[0m"; \
    	exit 1; \
    fi; \
    echo "\033[92mno problem.\033[0m";

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
		docker tag chatwork/`basename $$PWD`:latest chatwork/`basename $$PWD`:$$version-$(ARCH)$(SCOPE_SUFFIX); \
		docker push chatwork/`basename $$PWD`:$$version-$(ARCH)$(SCOPE_SUFFIX); \
	fi

.PHONY: manifest\:push
manifest\:push:
	@version=$$(docker inspect -f {{.Config.Labels.version}} chatwork/`basename $$PWD`:latest); \
	if docker inspect --format='{{index .RepoDigests 0}}' chatwork/$$(basename $$PWD):$$version >/dev/null 2>&1; then \
	  	echo "no changes"; \
	else \
		docker pull chatwork/flyway:$$version-aarch64$(SCOPE_SUFFIX); \
		docker pull chatwork/flyway:$$version-x86_64$(SCOPE_SUFFIX); \
		arm64_digest=$$(docker inspect -f '{{index .RepoDigests 0}}' chatwork/`basename $$PWD`:$$version-aarch64); \
        amd64_digest=$$(docker inspect -f '{{index .RepoDigests 0}}' chatwork/`basename $$PWD`:$$version-x86_64); \
		docker buildx imagetools create -t chatwork/`basename $$PWD`:$$version$(SCOPE_SUFFIX) $$arm64_digest $$amd64_digest; \
		docker buildx imagetools create -t chatwork/`basename $$PWD`:3.1-5.6$(SCOPE_SUFFIX) $$arm64_digest $$amd64_digest; \
		hub-tool tag rm chatwork/`basename $$PWD`:$$version-aarch64$(SCOPE_SUFFIX) -f; \
        hub-tool tag rm chatwork/`basename $$PWD`:$$version-x86_64$(SCOPE_SUFFIX) -f; \
    fi

.PHONY: manifest\:succeed-message
manifest\:succeed-message:
	@version=$$(docker inspect -f {{.Config.Labels.version}} chatwork/`basename $$PWD`:latest); \
	echo "Released new tags."; \
	echo "- chatwork/`basename $$PWD`:$$version$(SCOPE_SUFFIX)"; \
	echo "- chatwork/`basename $$PWD`:3.1-5.6$(SCOPE_SUFFIX)";
