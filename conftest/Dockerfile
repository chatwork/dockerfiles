FROM ubuntu:22.04

ARG TARGETARCH

ARG CONFTEST_VERSION=0.61.1
LABEL version="${CONFTEST_VERSION}"
LABEL maintainer="sakamoto@chatwork.com"

ARG CONFTEST_DEP_FILE="conftest_${CONFTEST_VERSION}_linux_${TARGETARCH}.deb"

RUN apt-get update -y && \
    apt-get install -y wget git

RUN wget -q https://github.com/open-policy-agent/conftest/releases/download/v${CONFTEST_VERSION}/${CONFTEST_DEP_FILE} && \
    dpkg -i ./${CONFTEST_DEP_FILE} && \
    rm -f ./${CONFTEST_DEP_FILE} && \
    apt-get clean  && \
    rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/usr/bin/conftest"]
CMD ["help"]
