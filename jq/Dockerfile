FROM alpine:3.8

ARG JQ_VERSION=1.6_rc1-r1

LABEL version="${JQ_VERSION}"
LABEL maintainer="ozaki@chatwork.com"

RUN apk --no-cache add jq=${JQ_VERSION}

ENTRYPOINT ["/usr/bin/jq"]
