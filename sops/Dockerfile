FROM chatwork/alpine-sdk:3.10

ARG SOPS_VERSION=3.5.0

LABEL version="${SOPS_VERSION}"
LABEL maintainer="sakamoto@chatwork.com"

ADD https://github.com/mozilla/sops/releases/download/v${SOPS_VERSION}/sops-v${SOPS_VERSION}.linux /usr/local/bin/sops

RUN chmod 755 /usr/local/bin/sops && \
    apk update && \
    apk add --no-cache jq && \
    rm -rf /var/cache/apk/*

ENTRYPOINT ["/usr/local/bin/sops"]
CMD ["help"]
