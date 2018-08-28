FROM alpine:3.8

LABEL version "2.7.2"
LABEL maintainer "j5ik2o@gmail.com"

ENV HELM_VERSION 2.7.2
ENV HELM_FILE_NAME helm-v${HELM_VERSION}-linux-amd64.tar.gz

WORKDIR /

RUN apk --update --no-cache add ca-certificates

ADD http://storage.googleapis.com/kubernetes-helm/${HELM_FILE_NAME} /tmp
RUN tar -zxvf /tmp/${HELM_FILE_NAME} -C /tmp \
  && mv /tmp/linux-amd64/helm /bin/helm \
  && rm -rf /tmp/*

ENTRYPOINT ["/bin/helm"]
