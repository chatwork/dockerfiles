FROM chatwork/alpine-sdk:3.11

ARG ENVSUBST_VERSION=1.1.0

LABEL version="v${ENVSUBST_VERSION}"
LABEL maintainer="sakamoto@chatwork.com"

ADD https://github.com/a8m/envsubst/releases/download/v${ENVSUBST_VERSION}/envsubst-Linux-x86_64 /usr/local/bin/envsubst

RUN chmod 755 /usr/local/bin/envsubst && \
    apk update && \
    apk add --no-cache jq && \
    rm -rf /var/cache/apk/*

ENTRYPOINT ["/usr/local/bin/envsubst"]
CMD ["-help"]
