FROM alpine:3.6

LABEL version="0.0.0"
LABEL maintainer="niinuma@chatwork.com"

ARG NR_VERSION=8.7.0.242
ARG NR_FILE_NAME=newrelic-php5-${NR_VERSION}-linux-musl
ARG GOM_VERSION=3.5.0

COPY build/docker-* /usr/local/bin/

RUN set -xe \
    && apk add --no-cache --virtual .run-deps socat \
    && apk add --no-cache --virtual .build-deps curl \
    && mkdir -p /tmp/newrelic \
    && rm -rf /etc/dpkg \
    && curl -Ss https://download.newrelic.com/php_agent/archive/$NR_VERSION/$NR_FILE_NAME.tar.gz | tar xvz -C /tmp/newrelic --strip 1 \
    && cp /tmp/newrelic/daemon/newrelic-daemon.x64 /usr/bin/newrelic-daemon \
    && rm -rf /tmp/*

VOLUME [ "/newrelic" ]

ENTRYPOINT ["docker-entrypoint"]

EXPOSE 3019
