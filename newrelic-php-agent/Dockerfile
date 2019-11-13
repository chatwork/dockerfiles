FROM alpine:3.6

ARG NR_VERSION=9.3.0.248
ARG NR_FILE_NAME=newrelic-php5-${NR_VERSION}-linux-musl

LABEL version="${NR_VERSION}"
LABEL maintainer="niinuma@chatwork.com"

COPY build/docker-* /usr/local/bin/

ADD  https://download.newrelic.com/php_agent/archive/$NR_VERSION/$NR_FILE_NAME.tar.gz /tmp/

RUN set -xe \
    && mkdir -p /tmp/newrelic \
    && tar xzf /tmp/$NR_FILE_NAME.tar.gz -C /tmp/newrelic --strip 1 \
    && cp /tmp/newrelic/daemon/newrelic-daemon.x64 /usr/bin/newrelic-daemon \
    && rm -rf /tmp/*

ENTRYPOINT ["docker-entrypoint"]

EXPOSE 3019
