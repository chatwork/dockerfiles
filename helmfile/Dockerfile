FROM chatwork/alpine-sdk:3.8

ARG KUBECTL_VERSION=1.12.1
ARG HELM_VERSION=2.10.0
ARG HELM_DIFF_VERSION=master
ARG HELM_SECRETS_VERSION=master
ARG HELMFILE_VERSION=0.40.1

ENV HELM_FILE_NAME helm-v${HELM_VERSION}-linux-amd64.tar.gz

LABEL version "${HELMFILE_VERSION}-${HELM_VERSION}-${KUBECTL_VERSION}"
LABEL maintainer "ozaki@chatwork.com"

WORKDIR /

RUN apk --update --no-cache add bash

ADD https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl /usr/local/bin/kubectl
RUN chmod +x /usr/local/bin/kubectl

ADD http://storage.googleapis.com/kubernetes-helm/${HELM_FILE_NAME} /tmp
RUN tar -zxvf /tmp/${HELM_FILE_NAME} -C /tmp \
  && mv /tmp/linux-amd64/helm /bin/helm \
  && rm -rf /tmp/* \
  && /bin/helm init --client-only

RUN mkdir -p "$(helm home)/plugins" && \
    helm plugin install https://github.com/databus23/helm-diff --version ${HELM_DIFF_VERSION} && \
    helm plugin install https://github.com/futuresimple/helm-secrets --version ${HELM_SECRETS_VERSION}

ADD https://github.com/roboll/helmfile/releases/download/v${HELMFILE_VERSION}/helmfile_linux_amd64 /bin/helmfile
RUN chmod 0755 /bin/helmfile

ENTRYPOINT ["/bin/helmfile"]
