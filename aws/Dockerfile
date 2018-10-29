FROM chatwork/alpine-sdk:3.8

ARG AWS_VERSION=1.16.39

LABEL version="${AWS_VERSION}"
LABEL maintainer="ozaki@chatwork.com"

RUN apk --no-cache add py3-pip jq \
    && pip3 install --no-cache-dir --upgrade pip \
    && pip3 install --no-cache-dir awscli==${AWS_VERSION}

ENTRYPOINT ["/usr/bin/aws"]
