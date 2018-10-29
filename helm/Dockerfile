FROM chatwork/alpine-sdk:3.8

ARG HELM_VERSION=2.10.0

LABEL version="${HELM_VERSION}"
LABEL maintainer="j5ik2o@gmail.com"

ENV HELM_FILE_NAME helm-v${HELM_VERSION}-linux-amd64.tar.gz

WORKDIR /

RUN apk --update --no-cache add ca-certificates

ADD http://storage.googleapis.com/kubernetes-helm/${HELM_FILE_NAME} /tmp
RUN tar -zxvf /tmp/${HELM_FILE_NAME} -C /tmp \
  && mv /tmp/linux-amd64/helm /bin/helm \
  && rm -rf /tmp/* \
  && /bin/helm init --client-only

ENTRYPOINT ["/bin/helm"]
