FROM alpine:3.7

ARG JQ_VERSION=1.5-r5

LABEL version="${JQ_VERSION}"
LABEL maintainer="ozaki@chatwork.com"

RUN apk --no-cache add jq=${JQ_VERSION}

ENTRYPOINT ["/usr/bin/jq"]
