.PHONY: build
build:
	@ls -d */ | xargs -I{} /bin/bash -c "cd ./{} && make build";

.PHONY: test
test:
	@ls -d */ | xargs -I{} /bin/bash -c "cd ./{} && make test";

.PHONY: push
push:
	@ls -d */ | xargs -I{} /bin/bash -c "cd ./{} && make push";

.PHONY: ci\:diff
ci\:diff:
	@branch=$$(git symbolic-ref --short HEAD); \
		if [[ "$${branch}" == "master" ]]; then \
			from=$$(git --no-pager log --merges -n 2 --pretty=format:"%H" | tail -n 1); \
			git diff --name-only "$${from}" "HEAD" | sed 's:^.*/compare/::g' | xargs -I{} dirname {} | sed 's/[.\/].*$$//' | sed '/^$$/d' | uniq; \
		else \
			git diff --name-only "HEAD" "master" | sed 's:^.*/compare/::g' | xargs -I{} dirname {} | sed 's/[.\/].*$$//' | sed '/^$$/d' | uniq; \
		fi

.PHONY: ci\:changelog
ci\:changelog:
	@if [ -n "${DIR}" ]; then \
		git log --no-merges --pretty=format:"- %s" $$(echo $$CIRCLE_COMPARE_URL | sed 's:^.*/compare/::g') -- ${DIR}; \
	else \
		git log --no-merges --pretty=format:"- %s" $$(echo $$CIRCLE_COMPARE_URL | sed 's:^.*/compare/::g'); \
	fi

.PHONY: ci\:notify
ci\:notify:
	docker run -e CHATWORK_TOKEN=$${CHATWORK_TOKEN} \
						 -e ROOM_ID=$${CHATWORK_NOTIFICATION_ROOM_ID} \
						 chatwork/chatwork-notify "[info][title]$${TITLE}[/title]$${BODY}[hr]$${CIRCLE_BUILD_URL}[/info]"
