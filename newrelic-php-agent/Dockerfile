FROM alpine:3.6

LABEL version="0.0.0"
LABEL maintainer="niinuma@chatwork.com"

ARG NR_VERSION=8.7.0.242
ARG NR_FILE_NAME=newrelic-php5-${NR_VERSION}-linux-musl

COPY build/docker-* /usr/local/bin/

ADD  https://download.newrelic.com/php_agent/archive/$NR_VERSION/$NR_FILE_NAME.tar.gz /tmp/

RUN set -xe \
    && apk --update --no-cache add --virtual .build-deps \
    && mkdir -p /tmp/newrelic \
    && tar xzf /tmp/$NR_FILE_NAME.tar.gz -C /tmp/newrelic --strip 1 \
    && cp /tmp/newrelic/daemon/newrelic-daemon.x64 /usr/bin/newrelic-daemon \
    && rm -rf /tmp/*

VOLUME [ "/newrelic" ]

ENTRYPOINT ["docker-entrypoint"]

EXPOSE 3019
