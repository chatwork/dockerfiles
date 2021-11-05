ARCH:=$(shell uname -m)
EXTENSION:=$(shell case "$(ARCH)" in \
	("arm64"|"aarch64") echo ".arm64" ;; \
	("x86_64") echo "" ;; \
	(*) echo $(ARCH) ;; \
esac)

.PHONY: build
build:
	@find . -type f -name "Dockerfile${EXTENSION}" | while read -r FILE; do \
		docker build -f Dockerfile -t chatwork/`basename $$PWD` .; \
      	version=$$(docker inspect -f {{.Config.Labels.version}} chatwork/`basename $$PWD`); \
      	if [ -n "$$version" ]; then \
            docker tag chatwork/`basename $$PWD`:latest chatwork/`basename $$PWD`:$$version; \
        fi \
    done

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
	if docker inspect --format='{{index .RepoDigests 0}}' chatwork/$$(basename $$PWD):$$version-$(ARCH) >/dev/null 2>&1; then \
		echo "no changes"; \
	else \
	  	docker tag chatwork/`basename $$PWD`:latest chatwork/flyway:$$version-$(ARCH)-dev; \
		docker push chatwork/flyway:$$version-$(ARCH)-dev; \
	fi

.PHONY: manifest\:push
manifest\:push:
	@version=$$(docker inspect -f {{.Config.Labels.version}} chatwork/`basename $$PWD`:latest); \
	if docker inspect --format='{{index .RepoDigests 0}}' chatwork/$$(basename $$PWD):$$version >/dev/null 2>&1; then \
		echo "no changes"; \
	else \
		docker pull chatwork/flyway:$$version-aarch64-dev; \
        docker pull chatwork/flyway:$$version-x86_64-dev; \
        arm64_digest=$$(docker inspect -f '{{index .RepoDigests 0}}' chatwork/flyway:$$version-aarch64-dev); \
        amd64_digest=$$(docker inspect -f '{{index .RepoDigests 0}}' chatwork/flyway:$$version-x86_64-dev); \
        docker buildx imagetools create -t chatwork/flyway:$$version-dev $$arm64_digest $$amd64_digest; \
        docker buildx imagetools create -t chatwork/flyway:5.7-dev $$arm64_digest $$amd64_digest; \
        docker buildx imagetools create -t chatwork/flyway:dev $$arm64_digest $$amd64_digest; \
		hub-tool tag rm chatwork/flyway:$$version-aarch64-dev -f; \
		hub-tool tag rm chatwork/flyway:$$version-x86_64-dev -f; \
	fi

.PHONY: manifest\:succeed-message
manifest\:succeed-message:
	@version=$$(docker inspect -f {{.Config.Labels.version}} chatwork/`basename $$PWD`:latest); \
	echo "Released new tags."; \
	echo "- chatwork/flyway:$$version-dev"; \
	echo "- chatwork/flyway:5.7-dev"; \
	echo "- chatwork/flyway:dev";
