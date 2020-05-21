FROM amazonlinux:2

ARG AWSCLI_VERSION=2.0.15

LABEL version="${AWSCLI_VERSION}"
LABEL maintainer="ozaki@chatwork.com"
LABEL maintainer="sakamoto@chatwork.com"

COPY entrypoint.sh /entrypoint.sh

RUN yum install jq unzip tar gzip -y \
    && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install \
    && rm -f awscliv2.zip \
    && yum clean all \
    && rm -rf /var/cache/yum/* \
    && chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
