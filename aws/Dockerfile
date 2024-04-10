ARG AWSCLI_VERSION=2.15.37

FROM amazon/aws-cli:${AWSCLI_VERSION}

ARG AWSCLI_VERSION=2.15.37
LABEL version="${AWSCLI_VERSION}"
LABEL maintainer="ozaki@chatwork.com"
LABEL maintainer="sakamoto@chatwork.com"

COPY entrypoint.sh /entrypoint.sh

RUN yum install jq unzip tar gzip -y \
    && yum clean all \
    && rm -rf /var/cache/yum/* \
    && chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
