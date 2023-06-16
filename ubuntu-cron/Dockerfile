FROM ubuntu:22.04

ARG TARGETARCH

LABEL version="22.04"
LABEL maintainer="sakamoto@chatwork.com"

RUN apt update -y \
    && apt upgrade -y \
    && apt install -q -y --no-install-recommends \
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
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

RUN case "${TARGETARCH}" in \
        "amd64") AWSCLI_ARCH=x86_64 ;; \
        "arm64") AWSCLI_ARCH=aarch64 ;; \
        *) echo "ERROR: 'TARGETARCH' value expected: ${TARGETARCH}"; exit 1 ;; \
    esac \
    && curl "https://awscli.amazonaws.com/awscli-exe-linux-${AWSCLI_ARCH}.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && sudo ./aws/install \
    && rm awscliv2.zip \
    && rm -r ./aws

RUN rm -Rf /etc/cron.daily
RUN rm -Rf /etc/cron.weekly
RUN rm -Rf /etc/cron.monthly
RUN rm -Rf /etc/cron.hourly

CMD ["tini", "---", "/bin/bash"]
