.PHONY: build
build:
	@ls -d */ | xargs -I{} /bin/bash -c "cd ./{} && make build || exit 255";

.PHONY: test
test:
	@ls -d */ | xargs -I{} /bin/bash -c "cd ./{} && make test || exit 255";

.PHONY: push
push:
	@ls -d */ | xargs -I{} /bin/bash -c "cd ./{} && make push || exit 255";

.PHONY: ci\:diff
ci\:diff:
	@git diff --name-only $$(echo $$CIRCLE_COMPARE_URL | sed 's:^.*/compare/::g') | xargs -I{} dirname {} | sed 's/[.\/].*$$//' | sed '/^$$/d' | uniq;

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
