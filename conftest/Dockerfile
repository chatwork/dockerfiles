FROM ubuntu:22.04

ARG TARGETARCH

ARG CONFTEST_VERSION=0.71.1
LABEL version="${CONFTEST_VERSION}"
LABEL maintainer="sakamoto@chatwork.com"

# CVE-2026-109518: the base image may still ship an APT older than the fixed
# version (2.4.15ubuntu0.1 on jammy). Disable download retries, which the
# vulnerability depends on, until APT itself has been upgraded in this layer.
# Remove "-o Acquire::Retries=0" once the base image ships the fixed APT.
RUN apt-get -o Acquire::Retries=0 update -y && \
    apt-get -o Acquire::Retries=0 install -y --only-upgrade apt && \
    apt-get -o Acquire::Retries=0 install -y wget git

RUN case "${TARGETARCH}" in \
        "amd64") CONFTEST_ARCH=x86_64 ;; \
        "arm64") CONFTEST_ARCH=arm64 ;; \
        *) echo "ERROR: 'TARGETARCH' value expected: ${TARGETARCH}"; exit 1 ;; \
    esac && \
    CONFTEST_DEP_FILE="conftest_${CONFTEST_VERSION}_Linux_${CONFTEST_ARCH}.deb" && \
    wget -q https://github.com/open-policy-agent/conftest/releases/download/v${CONFTEST_VERSION}/${CONFTEST_DEP_FILE} && \
    dpkg -i ./${CONFTEST_DEP_FILE} && \
    rm -f ./${CONFTEST_DEP_FILE} && \
    apt-get clean  && \
    rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/usr/bin/conftest"]
CMD ["help"]
