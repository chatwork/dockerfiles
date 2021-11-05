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
	  	docker tag chatwork/`basename $$PWD`:latest chatwork/flyway:$$version-$(ARCH); \
		docker push chatwork/flyway:$$version-$(ARCH); \
	fi

.PHONY: manifest\:push
manifest\:push:
	@version=$$(docker inspect -f {{.Config.Labels.version}} chatwork/`basename $$PWD`:latest); \
	if docker inspect --format='{{index .RepoDigests 0}}' chatwork/$$(basename $$PWD):$$version >/dev/null 2>&1; then \
		echo "no changes"; \
	else \
		docker pull chatwork/flyway:$$version-aarch64; \
        docker pull chatwork/flyway:$$version-x86_64; \
        arm64_digest=$$(docker inspect -f '{{index .RepoDigests 0}}' chatwork/flyway:$$version-aarch64); \
        amd64_digest=$$(docker inspect -f '{{index .RepoDigests 0}}' chatwork/flyway:$$version-x86_64); \
        docker buildx imagetools create -t chatwork/flyway:$$version $$arm64_digest $$amd64_digest; \
        docker buildx imagetools create -t chatwork/flyway:5.7 $$arm64_digest $$amd64_digest; \
        docker buildx imagetools create -t chatwork/flyway:latest $$arm64_digest $$amd64_digest; \
		hub-tool tag rm chatwork/flyway:$$version-aarch64 -f; \
		hub-tool tag rm chatwork/flyway:$$version-x86_64 -f; \
	fi

.PHONY: manifest\:succeed-message
manifest\:succeed-message:
	@version=$$(docker inspect -f {{.Config.Labels.version}} chatwork/`basename $$PWD`:latest); \
	echo "Released new tags."; \
	echo "- chatwork/flyway:$$version"; \
	echo "- chatwork/flyway:5.7"; \
	echo "- chatwork/flyway:latest";
