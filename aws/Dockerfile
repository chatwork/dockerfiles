FROM chatwork/alpine-sdk:3.10

ARG AWSCLI_VERSION=1.16.259

LABEL version="${AWSCLI_VERSION}"
LABEL maintainer="ozaki@chatwork.com"

COPY entrypoint.sh /entrypoint.sh

RUN apk --no-cache add python3 py3-pip groff jq \
    && pip3 install --no-cache-dir --upgrade pip \
    && pip3 install --no-cache-dir awscli==${AWSCLI_VERSION} \
    && chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
