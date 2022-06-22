ARG DOCKER_VERSION=20.10.17

FROM docker:${DOCKER_VERSION}-git

ARG DOCKER_VERSION=20.10.17

LABEL version="${DOCKER_VERSION}"
LABEL maintainer="ozaki@chatwork.com"

RUN apk --no-cache upgrade \
    && apk add --no-cache libffi-dev openssl-dev gcc libc-dev bash make curl jq docker-compose
