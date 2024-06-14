ARCH:=$(shell uname -m)
ENV:="prod"
LATEST_TAG:=$(shell if [ $(ENV) = "prod" ]; then \
 	echo "latest"; \
 	else \
 		echo "$(ENV)"; \
 	fi)
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
        aws_cli_version=$$(docker inspect -f {{.Config.Labels.aws_cli_version}} chatwork/`basename $$PWD`:latest); \
        php_version=$$(docker inspect -f {{.Config.Labels.php_version}} chatwork/`basename $$PWD`:latest); \
      	if [ -n "$$version" ] && [ -n "$$aws_cli_version" ] && [ -n "$$php_version" ]; then \
            docker tag chatwork/`basename $$PWD`:latest chatwork/`basename $$PWD`:$$version; \
        fi \
    done

.PHONY: check
check:
	@version=$$(docker inspect -f {{.Config.Labels.version}} chatwork/`basename $$PWD`:latest); \
    aws_cli_version=$$(docker inspect -f {{.Config.Labels.aws_cli_version}} chatwork/`basename $$PWD`:latest); \
    php_version=$$(docker inspect -f {{.Config.Labels.php_version}} chatwork/`basename $$PWD`:latest); \
    if [[ -z $$version ]]; then \
    	echo "\033[91mError: version is not defined in Dockerfile.\033[0m"; \
    	exit 1; \
    fi; \
    if [[ -z $$aws_cli_version ]]; then \
    	echo "\033[91mError: aws_cli_version is not defined in Dockerfile.\033[0m"; \
    	exit 1; \
    fi; \
    if [[ -z $$php_version ]]; then \
    	echo "\033[91mError: php_version is not defined in Dockerfile.\033[0m"; \
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
		docker pull chatwork/`basename $$PWD`:$$version-aarch64$(SCOPE_SUFFIX); \
		docker pull chatwork/`basename $$PWD`:$$version-x86_64$(SCOPE_SUFFIX); \
		arm64_digest=$$(docker inspect -f '{{index .RepoDigests 0}}' chatwork/`basename $$PWD`:$$version-aarch64$(SCOPE_SUFFIX)); \
        amd64_digest=$$(docker inspect -f '{{index .RepoDigests 0}}' chatwork/`basename $$PWD`:$$version-x86_64$(SCOPE_SUFFIX)); \
		docker buildx imagetools create -t chatwork/`basename $$PWD`:$$version$(SCOPE_SUFFIX) $$arm64_digest $$amd64_digest; \
		docker buildx imagetools create -t chatwork/`basename $$PWD`:$(LATEST_TAG) $$arm64_digest $$amd64_digest; \
		hub-tool tag rm chatwork/`basename $$PWD`:$$version-aarch64$(SCOPE_SUFFIX) -f; \
        hub-tool tag rm chatwork/`basename $$PWD`:$$version-x86_64$(SCOPE_SUFFIX) -f; \
    fi

.PHONY: manifest\:succeed-message
manifest\:succeed-message:
	@version=$$(docker inspect -f {{.Config.Labels.version}} chatwork/aws-cli-php:latest); \
	echo "Released new tags."; \
	echo "- chatwork/aws-cli-php:$$version$(SCOPE_SUFFIX)"; \
	echo "- chatwork/aws-cli-php:$(LATEST_TAG)";
