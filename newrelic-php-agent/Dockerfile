FROM alpine:3.6

LABEL version="0.0.0"
LABEL maintainer="niinuma@chatwork.com"

ARG NR_VERSION=8.7.0.242
ARG NR_FILE_NAME=newrelic-php5-${NR_VERSION}-linux-musl
ARG GOM_VERSION=3.5.0

COPY build/docker-* /usr/local/bin/
COPY build/newrelic.cfg.template /etc/newrelic/

RUN set -xe \
    && apk add --no-cache --virtual .run-deps socat \
    && apk add --no-cache --virtual .build-deps curl \
    && curl -SsL -o /usr/local/bin/gomplate https://github.com/hairyhenderson/gomplate/releases/download/v$GOM_VERSION/gomplate_linux-amd64-slim \
    && chmod 755 /usr/local/bin/gomplate \
    && mkdir -p /tmp/newrelic \
    && rm -rf /etc/dpkg \
    && curl -Ss https://download.newrelic.com/php_agent/archive/$NR_VERSION/$NR_FILE_NAME.tar.gz | tar xvz -C /tmp/newrelic --strip 1 \
    && cp /tmp/newrelic/daemon/newrelic-daemon.x64 /usr/bin/newrelic-daemon \
    && rm -rf /tmp/*

VOLUME [ "/newrelic" ]

ENTRYPOINT ["docker-entrypoint"]

EXPOSE 3019
