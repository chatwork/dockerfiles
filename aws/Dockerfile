FROM chatwork/alpine:3.8

ARG AWS_VERSION=1.16.39

LABEL version "${AWS_VERSION}"
LABEL maintainer "ozaki@chatwork.com"

RUN apk --no-cache add jq \
    && pip install --no-cache-dir awscli==${AWS_VERSION}

ENTRYPOINT ["/usr/local/bin/aws"]
