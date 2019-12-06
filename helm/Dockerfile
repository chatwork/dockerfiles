ARG HELM_VERSION=3.0.1

FROM alpine/helm:${HELM_VERSION}

ARG HELM_VERSION=3.0.1
LABEL version="${HELM_VERSION}"
LABEL maintainer="sakamoto@chatwork.com"

WORKDIR /

RUN apk --update --no-cache add ca-certificates bash

ENTRYPOINT ["/usr/bin/helm"]
