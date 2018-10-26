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
		@if [ "$(shell git symbolic-ref --short HEAD)" = "master" ]; then \
			git --no-pager log --merges -n 2 --pretty=format:"%H" | tail -n 1; \
		else \
			echo "HEAD"; \
		fi

.PHONY: ci\:diff\:to
ci\:diff\:to:
		@if [ "$(shell git symbolic-ref --short HEAD)" = "master" ]; then \
			echo "HEAD"; \
		else \
			echo "remotes/origin/master"; \
		fi

.PHONY: ci\:diff
ci\:diff:
	@git --no-pager diff --name-only "$(shell make ci:diff:from)" "$(shell make ci:diff:to)" | sed 's:^.*/compare/::g' | xargs -I{} dirname {} | sed 's/[.\/].*$$//' | sed '/^$$/d' | uniq;

.PHONY: ci\:changelog
ci\:changelog:
	@if [ -n "${DIR}" ]; then \
		git --no-pager log --no-merges --pretty=format:"- %s" "$(shell make ci:diff:from)...$(shell make ci:diff:to)" -- ${DIR}; \
	else \
		git --no-pager log --no-merges --pretty=format:"- %s" "$(shell make ci:diff:from)...$(shell make ci:diff:to)"; \
	fi

.PHONY: ci\:notify
ci\:notify:
	docker run -e CHATWORK_TOKEN=$${CHATWORK_TOKEN} \
						 -e ROOM_ID=$${CHATWORK_NOTIFICATION_ROOM_ID} \
						 chatwork/chatwork-notify "[info][title]$${TITLE}[/title]$${BODY}[hr]$${CIRCLE_BUILD_URL}[/info]"
