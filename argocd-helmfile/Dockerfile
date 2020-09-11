FROM argoproj/argocd:v1.7.4

LABEL version="1.7.4-0.129.0"
LABEL maintainer="shinya@chatwork.com"

# Switch to root for the ability to perform install
USER root

ARG HELMFILE_VERSION=v0.129.0
ARG KUBECTL_VERSION=1.17.5
ARG SOPS_VERSION=3.2.0
ARG HELM_DIFF_VERSION=3.1.1
# Install tools needed for your repo-server to retrieve & decrypt secrets, render manifests
# (e.g. curl, awscli, gpg, sops)
RUN apt-get update && \
    apt-get install -y curl gpg apt-utils && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    curl -o /usr/local/bin/helmfile -L https://github.com/roboll/helmfile/releases/download/${HELMFILE_VERSION}/helmfile_linux_amd64 && \
    curl -o /usr/local/bin/sops -L https://github.com/mozilla/sops/releases/download/${SOPS_VERSION}/sops-${SOPS_VERSION}.linux && \
    curl -o /usr/local/bin/kubectl -L https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl && \
    chmod +x /usr/local/bin/kubectl && \
    chmod +x /usr/local/bin/helmfile && \
    chmod +x /usr/local/bin/sops

# Switch back to non-root user
USER argocd

RUN helm plugin install https://github.com/databus23/helm-diff --version v${HELM_DIFF_VERSION} && \
    helm plugin install https://github.com/futuresimple/helm-secrets && \
    helm plugin install https://github.com/hypnoglow/helm-s3.git && \
    helm plugin install https://github.com/mumoshu/helm-x  && \
    helm plugin install https://github.com/aslafy-z/helm-git.git

