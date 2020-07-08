FROM argoproj/argocd:{{ .argocd_version }}

LABEL version="{{ .argocd_version }}"
LABEL maintainer="shinya@chatwork.com"

# Switch to root for the ability to perform install
USER root

ARG HELMFILE_VERSION={{ .helmfile_version }}
ARG KUBECTL_VERSION=1.17.5

# Install tools needed for your repo-server to retrieve & decrypt secrets, render manifests
# (e.g. curl, awscli, gpg, sops)
RUN apt-get update && \
    apt-get install -y curl gpg apt-utils && \
    apt-get clean && \
    curl -o /usr/local/bin/helmfile -L https://github.com/roboll/helmfile/releases/download/${HELMFILE_VERSION}/helmfile_linux_amd64 && \
    curl -o /usr/local/bin/sops -L https://github.com/mozilla/sops/releases/download/3.2.0/sops-3.2.0.linux && \
    curl -o /usr/local/bin/kubectl -L https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl && \
    chmod +x /usr/local/bin/kubectl && \
    chmod +x /usr/local/bin/helmfile && \
    chmod +x /usr/local/bin/sops

# Switch back to non-root user
USER argocd

RUN helm plugin install https://github.com/databus23/helm-diff --version v3.1.1 && \
    helm plugin install https://github.com/futuresimple/helm-secrets && \
    helm plugin install https://github.com/hypnoglow/helm-s3.git && \
    helm plugin install https://github.com/mumoshu/helm-x  && \
    helm plugin install https://github.com/aslafy-z/helm-git.git

