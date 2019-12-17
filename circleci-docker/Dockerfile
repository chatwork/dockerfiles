ARG DOCKER_VERSION=18.09.3

FROM docker:${DOCKER_VERSION}-git

ARG DOCKER_VERSION=18.09.3

LABEL version="${DOCKER_VERSION}"
LABEL maintainer="ozaki@chatwork.com"

RUN apk add --no-cache py-pip python-dev libffi-dev openssl-dev gcc libc-dev bash make curl jq \
    && pip --no-cache-dir install docker-compose
