FROM python:3.7.14-alpine3.16

ARG YQ_VERSION=3.1.0

LABEL version="${YQ_VERSION}"
LABEL maintainer="ozaki@chatwork.com"

RUN apk --no-cache add jq \
    && pip install --no-cache-dir yq==${YQ_VERSION}

ENTRYPOINT ["/usr/local/bin/yq"]
