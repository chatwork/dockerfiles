PHONY: build
docker-build:
	@find . -type d -maxdepth 1 | xargs -I{} /bin/bash -c "cd dockerfiles/{} && make build";

PHONY: test
docker-test:
	@find . -type d -maxdepth 1 | xargs -I{} /bin/bash -c "cd dockerfiles/{} && make test";
