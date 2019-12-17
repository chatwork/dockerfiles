FROM chatwork/alpine-sdk:3.10

ARG HELM_VERSION=3.0.2
LABEL version="${HELM_VERSION}"
LABEL maintainer="sakamoto@chatwork.com"
LABEL maintainer="ozaki@chatwork.com"

ENV HELM_FILE_NAME helm-v${HELM_VERSION}-linux-amd64.tar.gz

WORKDIR /

RUN apk --update --no-cache add ca-certificates bash

ADD https://get.helm.sh/${HELM_FILE_NAME} /tmp

RUN tar -zxvf /tmp/${HELM_FILE_NAME} -C /tmp \
  && mv /tmp/linux-amd64/helm /usr/bin/helm \
  && rm -rf /tmp/*

ENTRYPOINT ["/usr/bin/helm"]
