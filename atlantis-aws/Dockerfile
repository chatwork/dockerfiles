FROM chatwork/aws:2.8.3

ARG TARGETARCH
ARG ATLANTIS_VERSION=0.20.1
ENV DEFAULT_TERRAFORM_VERSION=1.3.2
LABEL version="${ATLANTIS_VERSION}"
LABEL maintainer="sakamoto@chatwork.com"

# In the official Atlantis image we only have the latest of each Terraform version.
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN AVAILABLE_TERRAFORM_VERSIONS="0.11.15 0.12.31 0.13.7 0.14.11 0.15.5 1.0.11 1.1.9 1.2.9 ${DEFAULT_TERRAFORM_VERSION}" && \
    case "${TARGETARCH}" in \
        "amd64") TERRAFORM_ARCH=amd64 ;; \
        "arm64") TERRAFORM_ARCH=arm64 ;; \
        *) echo "ERROR: 'TARGETARCH' value expected: ${TARGETARCH}"; exit 1 ;; \
    esac && \
    for VERSION in ${AVAILABLE_TERRAFORM_VERSIONS}; do \
        curl -LOs "https://releases.hashicorp.com/terraform/${VERSION}/terraform_${VERSION}_linux_${TERRAFORM_ARCH}.zip" && \
        curl -LOs "https://releases.hashicorp.com/terraform/${VERSION}/terraform_${VERSION}_SHA256SUMS" && \
        sed -n "/terraform_${VERSION}_linux_${TERRAFORM_ARCH}.zip/p" "terraform_${VERSION}_SHA256SUMS" | sha256sum -c && \
        mkdir -p "/usr/local/bin/tf/versions/${VERSION}" && \
        unzip "terraform_${VERSION}_linux_${TERRAFORM_ARCH}.zip" -d "/usr/local/bin/tf/versions/${VERSION}" && \
        ln -s "/usr/local/bin/tf/versions/${VERSION}/terraform" "/usr/local/bin/terraform${VERSION}" && \
        rm "terraform_${VERSION}_linux_${TERRAFORM_ARCH}.zip" && \
        rm "terraform_${VERSION}_SHA256SUMS"; \
    done && \
    ln -s "/usr/local/bin/tf/versions/${DEFAULT_TERRAFORM_VERSION}/terraform" /usr/local/bin/terraform

ARG CONFTEST_VERSION=0.34.0
ARG CONFTEST_RPM_FILE="conftest_${CONFTEST_VERSION}_linux_${TARGETARCH}.rpm"

RUN curl -LOs https://github.com/open-policy-agent/conftest/releases/download/v${CONFTEST_VERSION}/${CONFTEST_RPM_FILE} && \
    rpm -i ./${CONFTEST_RPM_FILE} && \
    rm -f ./${CONFTEST_RPM_FILE}

RUN curl -LOs https://github.com/runatlantis/atlantis/releases/download/v${ATLANTIS_VERSION}/atlantis_linux_${TARGETARCH}.zip && \
    unzip ./atlantis_linux_${TARGETARCH}.zip && \
    mv ./atlantis /usr/local/bin/atlantis && \
    curl -LOs https://raw.githubusercontent.com/runatlantis/atlantis/v${ATLANTIS_VERSION}/docker-entrypoint.sh && \
    mv ./docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh && \
    chmod +x /usr/local/bin/docker-entrypoint.sh && \
    rm -f ./atlantis_linux_${TARGETARCH}.zip

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["server"]
