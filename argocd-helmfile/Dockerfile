FROM quay.io/argoproj/argocd:v2.10.1

LABEL version="2.10.1-0.161.0"
LABEL maintainer="shinya@chatwork.com"
LABEL maintainer="sakamoto@chatwork.com"

# Switch to root for the ability to perform install
USER root

ARG TARGETOS
ARG TARGETARCH

ARG HELMFILE_VERSION=0.161.0
ARG HELM_VERSION=3.14.2
ARG HELM_LOCATION="https://get.helm.sh"
ARG HELM_FILE_NAME="helm-v${HELM_VERSION}-${TARGETOS}-${TARGETARCH}.tar.gz"
ARG HELMFILE_FILE_NAME="helmfile_${HELMFILE_VERSION}_${TARGETOS}_${TARGETARCH}.tar.gz"
ARG KUBECTL_VERSION=1.28.7
ARG SOPS_VERSION=3.7.3
ARG HELM_DIFF_VERSION=3.8.1
ARG HELM_SECRETS_VERSION=4.4.2
ARG HELM_GIT_VERSION=0.14.0

# Install tools needed for your repo-server to retrieve & decrypt secrets, render manifests
# (e.g. curl, awscli, gpg, sops)

RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install -y curl gpg apt-utils \
    && apt-get clean  \
    && rm -rf /var/lib/apt/lists/*

# kubectl
ADD https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/${TARGETOS}/${TARGETARCH}/kubectl /tmp
RUN mv /tmp/kubectl /usr/local/bin/kubectl \
  && chmod 755 /usr/local/bin/kubectl

# helm
ADD https://get.helm.sh/${HELM_FILE_NAME} /tmp
RUN tar -zxvf /tmp/${HELM_FILE_NAME} -C /tmp \
  && mv /tmp/${TARGETOS}-${TARGETARCH}/helm /usr/local/bin/helm \
  && chmod 755 /usr/local/bin/helm \
  && rm -rf /tmp/*

# helmfile
ADD https://github.com/helmfile/helmfile/releases/download/v${HELMFILE_VERSION}/${HELMFILE_FILE_NAME} /tmp
RUN tar -zxvf /tmp/${HELMFILE_FILE_NAME} -C /tmp \
  && mv /tmp/helmfile /usr/local/bin/helmfile \
  && chmod 755 /usr/local/bin/helmfile \
  && rm -rf /tmp/*

# sops
ADD https://github.com/mozilla/sops/releases/download/v${SOPS_VERSION}/sops-v${SOPS_VERSION}.${TARGETOS}.${TARGETARCH} /usr/local/bin/sops
RUN chmod 755 /usr/local/bin/sops

# Switch back to non-root user
USER argocd

RUN helm plugin install https://github.com/databus23/helm-diff --version v${HELM_DIFF_VERSION} && \
    helm plugin install https://github.com/jkroepke/helm-secrets --version v${HELM_SECRETS_VERSION} && \
    helm plugin install https://github.com/aslafy-z/helm-git.git --version v${HELM_GIT_VERSION}
