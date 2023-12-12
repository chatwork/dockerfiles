FROM chatwork/alpine-sdk:3.16

ARG SOPS_VERSION=3.8.1
ARG TARGETOS
ARG TARGETARCH

LABEL version="${SOPS_VERSION}"
LABEL maintainer="sakamoto@chatwork.com"

ADD https://github.com/mozilla/sops/releases/download/v${SOPS_VERSION}/sops-v${SOPS_VERSION}.${TARGETOS}.${TARGETARCH} /usr/local/bin/sops

RUN chmod 755 /usr/local/bin/sops && \
    apk update && \
    apk --no-cache upgrade && \
    apk add --no-cache jq && \
    rm -rf /var/cache/apk/*

ENTRYPOINT ["/usr/local/bin/sops"]
CMD ["help"]
