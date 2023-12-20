FROM alpine:3.16

ARG NR_VERSION=10.15.0.4
ARG NR_FILE_NAME=newrelic-php5-${NR_VERSION}-linux-musl

LABEL version="${NR_VERSION}"
LABEL maintainer="niinuma@chatwork.com"

COPY build/docker-* /usr/local/bin/

ADD  https://download.newrelic.com/php_agent/archive/$NR_VERSION/$NR_FILE_NAME.tar.gz /tmp/

RUN set -xe \
    && mkdir -p /tmp/newrelic \
    && tar xzf /tmp/$NR_FILE_NAME.tar.gz -C /tmp/newrelic --strip 1 \
    && export NR_INSTALL_SILENT=1 \
    && tmp/newrelic/newrelic-install install_daemon \
    && rm -rf /tmp/*

EXPOSE 31339

ENTRYPOINT ["docker-entrypoint"]
