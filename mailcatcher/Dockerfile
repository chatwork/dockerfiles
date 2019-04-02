FROM ruby:2.6-alpine3.9

LABEL version="0.1.0"

RUN set -xe \
    && apk add --no-cache \
        libstdc++ \
        sqlite-libs \
    && apk add --no-cache --virtual .build-deps \
        build-base \
        sqlite-dev \
    && gem install mailcatcher -v 0.7.1 --no-document \
    && apk del .build-deps

# smtp
EXPOSE 1025

# http
EXPOSE 1080

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]


