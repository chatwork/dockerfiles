.PHONY: build
build:
	@ls -d */ | xargs -I{} /bin/bash -c "cd ./{} && make build || exit 255";

.PHONY: test
test:
	@ls -d */ | xargs -I{} /bin/bash -c "cd ./{} && make test || exit 255";

.PHONY: push
push:
	@ls -d */ | xargs -I{} /bin/bash -c "cd ./{} && make push || exit 255";

.PHONY: ci\:diff\:from
ci\:diff\:from:
	@if [ "$(shell git rev-parse --abbrev-ref HEAD)" = "master" ]; then \
	    git --no-pager log --first-parent master --merges -n 2 --pretty=format:"%H" | tail -n 1; \
	else \
		echo "remotes/origin/master"; \
	fi

.PHONY: ci\:diff\:to
ci\:diff\:to:
	@echo "HEAD";

.PHONY: ci\:diff
ci\:diff:
	@git --no-pager diff --diff-filter=ACMRTUXB --name-only "$(shell make ci:diff:from)" "$(shell make ci:diff:to)" \
	  | sed 's:^.*/compare/::g' \
	  | grep -v goss/ \
	  | grep -v hooks/ \
	  | grep -v docker-compose.test.yml \
	  | grep -v Makefile \
	  | grep -v README.md \
	  | grep -v variant.lock \
	  | grep -v variant.mod \
	  | xargs -I{} dirname {} \
	  | xargs -I{} sh -c "test -d {} && echo {}" \
	  | sed 's/[.\/].*$$//' \
	  | sed '/^$$/d' \
	  | uniq;

.PHONY: ci\:changelog
ci\:changelog:
	@if [ -n "${DIR}" ]; then \
		git --no-pager log --no-merges --pretty=format:"- %s" "$(shell make ci:diff:from)...$(shell make ci:diff:to)" -- ${DIR}; \
	else \
		git --no-pager log --no-merges --pretty=format:"- %s" "$(shell make ci:diff:from)...$(shell make ci:diff:to)"; \
	fi

.PHONY: ci\:notify
ci\:notify:
	docker run -e CHATWORK_TOKEN=$${CHATWORK_API_TOKEN} \
						 -e ROOM_ID=$${CHATWORK_NOTIFICATION_ROOM_ID} \
						 chatwork/chatwork-notify "[info][title]$${TITLE}[/title]$${BODY}[hr]$${CIRCLE_BUILD_URL}[/info]"

.PHONY: arch
arch:
	@uname -m

.PHONY: extension
extension:
	@case $(shell make arch) in \
		("arm64"|"aarch64") echo ".arm64v8"; ;; \
		("x86_64") echo "" ;; \
		(*) echo $(shell make arch) ;; \
	esac
