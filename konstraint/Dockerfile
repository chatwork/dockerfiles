FROM alpine:3.19
ARG TARGETARCH
ARG KONSTRAINT_VERSION=0.43.0
LABEL version="${KONSTRAINT_VERSION}"
LABEL maintainer="sakamoto@chatwork.com"

RUN apk add --no-cache curl tar \
    && ARCH=$(case ${TARGETARCH} in amd64) echo "x86_64";; arm64) echo "arm64";; *) echo ${TARGETARCH};; esac) \
    && curl -sL https://github.com/plexsystems/konstraint/releases/download/v${KONSTRAINT_VERSION}/konstraint_Linux_${ARCH}.tar.gz | tar xz -C /usr/local/bin konstraint \
    && chmod 755 /usr/local/bin/konstraint \
    && apk del curl tar

ENTRYPOINT ["konstraint"]
