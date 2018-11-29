FROM chatwork/alpine-sdk:3.8

ARG OPENSSL_VERSION=1.0.2q-r0

LABEL version="${OPENSSL_VERSION}"
LABEL maintainer="sakamoto@chatwork.com"

RUN apk update && \
    apk add --no-cache openssl=${OPENSSL_VERSION} && \
    rm -rf /var/cache/apk/*

ENTRYPOINT ["openssl"]
CMD ["version"]
