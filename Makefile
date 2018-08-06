PHONY: build
build:
	@ls -d */ | xargs -I{} /bin/bash -c "cd ./{} && make build";

PHONY: test
test:
	@ls -d */ | xargs -I{} /bin/bash -c "cd ./{} && make test";

PHONY: push
push:
	@ls -d */ | xargs -I{} /bin/bash -c "cd ./{} && make push";
