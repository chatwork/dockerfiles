FROM ubuntu:22.04

ARG TARGETARCH
ARG TARGETOS

ARG KUBECTL_VERSION=1.28.7

LABEL version="22.04"
LABEL maintainer="sakamoto@chatwork.com"

RUN apt update -y \
    && apt upgrade -y \
    && DEBIAN_FRONTEND=noninteractive apt install -q -y --no-install-recommends \
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
