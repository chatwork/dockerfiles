FROM chatwork/alpine-sdk:3.10

ARG AWS_VERSION=1.16.190

LABEL version="${AWS_VERSION}"
LABEL maintainer="ozaki@chatwork.com"

COPY entrypoint.sh /entrypoint.sh

RUN apk --no-cache add py3-pip groff jq \
    && pip3 install --no-cache-dir --upgrade pip \
    && pip3 install --no-cache-dir awscli==${AWS_VERSION} \
    && chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
