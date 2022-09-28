FROM chatwork/alpine-sdk:3.16

ARG ENVSUBST_VERSION=1.2.0
ARG TARGETARCH

LABEL version="v${ENVSUBST_VERSION}"
LABEL maintainer="sakamoto@chatwork.com"

RUN case "${TARGETARCH}" in \
        "amd64") ENVSUBST_ARCH=x86_64 ;; \
        "arm64") ENVSUBST_ARCH=arm64 ;; \
        *) echo "ERROR: 'TARGETARCH' value expected: ${TARGETARCH}"; exit 1 ;; \
    esac && \
    curl -LOs https://github.com/a8m/envsubst/releases/download/v${ENVSUBST_VERSION}/envsubst-Linux-${ENVSUBST_ARCH} && \
    mv ./envsubst-Linux-${ENVSUBST_ARCH} /usr/local/bin/envsubst && \
    chmod 755 /usr/local/bin/envsubst

ENTRYPOINT ["/usr/local/bin/envsubst"]
CMD ["-help"]
