ARG ARGO_VERSION=v0.12.3

FROM argoproj/argocd:${ARGO_VERSION}

ARG HELM_DIFF_VERSION=master
ARG HELM_SECRETS_VERSION=master
ARG HELM_IMPORT_VERSION=0.2.1
ARG HELM_TILLER_VERSION=v0.6.7
ARG HELMFILE_VERSION=0.45.3

LABEL version="0.12.3"
LABEL maintainer="ozaki@chatwork.com"

USER root

RUN apt-get update && \
    apt-get install -y sudo && \
    apt-get install -y apt-utils && \
    apt-get install -y wget && \
    apt-get install -y curl

ADD https://github.com/roboll/helmfile/releases/download/v${HELMFILE_VERSION}/helmfile_linux_amd64 /bin/helmfile
RUN chmod 0755 /bin/helmfile

ENV HELM_HOME /home/argocd/.helm
RUN mkdir -p "$(helm home)/plugins" && \
    helm init --client-only && \
    helm plugin install https://github.com/k-kinzal/helm-import --version ${HELM_IMPORT_VERSION}  && \
    helm plugin install https://github.com/databus23/helm-diff --version ${HELM_DIFF_VERSION} && \
    helm plugin install https://github.com/futuresimple/helm-secrets --version ${HELM_SECRETS_VERSION} && \
    helm plugin install https://github.com/rimusz/helm-tiller --version ${HELM_TILLER_VERSION} && \
    helm tiller install && \
    chown -R argocd:argocd /home/argocd/.helm

USER argocd

WORKDIR /home/argocd
