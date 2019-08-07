FROM alpine:3.6

LABEL version="0.0.0"
LABEL maintainer="niinuma@chatwork.com"

ENV NR_PORT /tmp/.newrelic.sock
ENV LICENSE_KEY 123
ENV APPLICATION_NAME sample

ARG NR_VERSION=${NR_VERSION}
ARG NR_FILE_NAME=newrelic-php5-${NR_VERSION}-linux-musl
ARG NR_FILE_URL=https://download.newrelic.com/php_agent/archive/$NR_VERSION/${NR_FILE_NAME}.tar.gz

COPY entrypoint.sh /entrypoint.sh
COPY config/newrelic.ini /usr/local/etc/php/conf.d/newrelic.ini

RUN set -ex; \
    apk --no-cache add curl; \
    curl --connect-timeout 10 -o nr.tar.gz -fSL $NR_FILE_URL; \
    tar -xf nr.tar.gz; \
    cp $NR_FILE_NAME/daemon/newrelic-daemon.x64 /usr/local/bin/newrelic-daemon; \
    mkdir -p /var/log/newrelic; \
    rm -rf newrelic-php5* nr.tar.gz; \
    chmod +x /entrypoint.sh;

ENTRYPOINT ["/entrypoint.sh"]
