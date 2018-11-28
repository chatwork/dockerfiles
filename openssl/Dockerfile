FROM chatwork/alpine-sdk:3.8

ARG OPENSSL_VERSION=latest

LABEL version="${OPENSSL_VERSION}"
LABEL maintainer="sakamoto@chatwork.com"

RUN apk update && \
    apk add --no-cache openssl && \
    rm -rf /var/cache/apk/*

ENTRYPOINT ["openssl"]
CMD ["version"]
