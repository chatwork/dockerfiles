FROM ubuntu:22.04

ARG TARGETARCH
ARG TARGETOS

ARG KUBECTL_VERSION=1.28.7

LABEL version="22.04"
LABEL maintainer="sakamoto@chatwork.com"

# CVE-2026-109518: the base image may still ship an APT older than the fixed
# version (2.4.15ubuntu0.1 on jammy). Disable download retries, which the
# vulnerability depends on, until APT itself has been upgraded in this layer.
# Remove "-o Acquire::Retries=0" once the base image ships the fixed APT.
RUN apt -o Acquire::Retries=0 update -y \
    && apt -o Acquire::Retries=0 upgrade -y \
    && DEBIAN_FRONTEND=noninteractive apt -o Acquire::Retries=0 install -q -y --no-install-recommends \
       curl \
       wget \
       ca-certificates \
       git \
       jq \
       sudo \
       unzip \
       zip \
       cron \
       tini \
       bash \
       tzdata \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

RUN case "${TARGETARCH}" in \
        "amd64") AWSCLI_ARCH=x86_64 ;; \
        "arm64") AWSCLI_ARCH=aarch64 ;; \
        *) echo "ERROR: 'TARGETARCH' value expected: ${TARGETARCH}"; exit 1 ;; \
    esac \
    && curl "https://awscli.amazonaws.com/awscli-exe-${TARGETOS}-${AWSCLI_ARCH}.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && sudo ./aws/install \
    && rm awscliv2.zip \
    && rm -r ./aws

# kubectl
ADD https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/${TARGETOS}/${TARGETARCH}/kubectl /tmp
RUN mv /tmp/kubectl /usr/local/bin/kubectl \
  && chmod 755 /usr/local/bin/kubectl

RUN rm -Rf /etc/cron.daily
RUN rm -Rf /etc/cron.weekly
RUN rm -Rf /etc/cron.monthly
RUN rm -Rf /etc/cron.hourly

CMD ["tini", "---", "/bin/bash"]
