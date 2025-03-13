FROM alpine:3.19
ARG TARGETARCH
ARG KONSTRAINT_VERSION=0.41.0
LABEL version="${KONSTRAINT_VERSION}"
LABEL maintainer="sakamoto@chatwork.com"

RUN if [ "${TARGETARCH}" == "arm64" ]; then ARCH=arm64; else ARCH=x86_64; fi \
    && apk update \
    && apk add curl \
    && curl -sL https://github.com/plexsystems/konstraint/releases/download/v${KONSTRAINT_VERSION}/konstraint_Linux_${ARCH}.tar.gz | tar xz -C ./ \
    && mv ./konstraint /usr/local/bin/konstraint \
    && chmod 755 /usr/local/bin/konstraint

ENTRYPOINT ["konstraint"]
