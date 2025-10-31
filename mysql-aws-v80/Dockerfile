FROM mysql:8.0.44

LABEL version="8.0.44-2.31.27"

ARG TARGETOS
ARG TARGETARCH

ARG MYSQL_VERSION=8.0.44
ARG AWSCLI_VERSION=2.31.27
ARG VAULT_VERSION=1.20.4

RUN microdnf update -y \
    && microdnf upgrade -y \
    && microdnf install -y curl jq unzip \
    && microdnf clean all

RUN AWS_CLI_ARCH="" \
    && case ${TARGETARCH} in \
    "amd64") AWS_CLI_ARCH=x86_64 ;; \
    "arm64") AWS_CLI_ARCH=aarch64 ;; \
    *) echo "no match PLATFORM"; exit 1 ;; \
    esac \
    && echo ${AWS_CLI_ARCH} \
    && cd /tmp \
    && curl "https://awscli.amazonaws.com/awscli-exe-${TARGETOS}-${AWS_CLI_ARCH}-${AWSCLI_VERSION}.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install \
    && cd ${HOME} \
    && rm -rf /tmp/*

RUN curl "https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_${TARGETOS}_${TARGETARCH}.zip" -o "vault.zip" \
    && unzip vault.zip \
    && mv vault /usr/local/bin/ \
    && chmod +x /usr/local/bin/vault \
    && rm vault.zip
