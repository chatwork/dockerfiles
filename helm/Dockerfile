FROM chatwork/alpine-sdk:3.16

ARG HELM_VERSION=3.14.1
LABEL version="${HELM_VERSION}"
LABEL maintainer="sakamoto@chatwork.com"
LABEL maintainer="ozaki@chatwork.com"

ARG TARGETOS
ARG TARGETARCH

ENV HELM_FILE_NAME helm-v${HELM_VERSION}-${TARGETOS}-${TARGETARCH}.tar.gz

WORKDIR /

RUN apk upgrade --no-cache \
    && apk --no-cache add ca-certificates bash

ADD https://get.helm.sh/${HELM_FILE_NAME} /tmp

RUN tar -zxvf /tmp/${HELM_FILE_NAME} -C /tmp \
  && mv /tmp/${TARGETOS}-${TARGETARCH}/helm /usr/bin/helm \
  && rm -rf /tmp/*

ENTRYPOINT ["/usr/bin/helm"]
