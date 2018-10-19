.PHONY: build
build:
	@ls -d */ | xargs -I{} /bin/bash -c "cd ./{} && make build";

.PHONY: test
test:
	@ls -d */ | xargs -I{} /bin/bash -c "cd ./{} && make test";

.PHONY: push
push:
	@ls -d */ | xargs -I{} /bin/bash -c "cd ./{} && make push";

.PHONY: ci\:diff\:from
ci\:diff\:from:
	@branch=$$(git symbolic-ref --short HEAD); \
		if [[ "$${branch}" == "master" ]]; then \
			git --no-pager log --merges -n 2 --pretty=format:"%H" | tail -n 1; \
		else \
			echo "HEAD"; \
		fi

.PHONY: ci\:diff\:to
ci\:diff\:to:
	@branch=$$(git symbolic-ref --short HEAD); \
		if [[ "$${branch}" == "master" ]]; then \
			echo "HEAD"; \
		else \
			echo "master"; \
		fi

.PHONY: ci\:diff
ci\:diff:
	@git diff --name-only "$$(make ci:diff:from)" "$$(make ci:diff:to)" | sed 's:^.*/compare/::g' | xargs -I{} dirname {} | sed 's/[.\/].*$$//' | sed '/^$$/d' | uniq;

.PHONY: ci\:changelog
ci\:changelog:
	@if [ -n "${DIR}" ]; then \
		git --no-pager log --no-merges --pretty=format:"- %s" "$$(make ci:diff:from)...$$(make ci:diff:to)" -- ${DIR}; \
	else \
		git --no-pager log --no-merges --pretty=format:"- %s" "$$(make ci:diff:from)...$$(make ci:diff:to)"; \
	fi

.PHONY: ci\:notify
ci\:notify:
	docker run -e CHATWORK_TOKEN=$${CHATWORK_TOKEN} \
						 -e ROOM_ID=$${CHATWORK_NOTIFICATION_ROOM_ID} \
						 chatwork/chatwork-notify "[info][title]$${TITLE}[/title]$${BODY}[hr]$${CIRCLE_BUILD_URL}[/info]"
