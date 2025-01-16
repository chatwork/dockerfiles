FROM ubuntu:22.04

ARG TARGETOS
ARG TARGETARCH

ARG KUBECTL_VERSION=1.31.5
ARG HELMFILE_VERSION=0.169.2
ARG HELM_VERSION=3.17.0
ARG HELM_FILE_NAME=helm-v${HELM_VERSION}-${TARGETOS}-${TARGETARCH}.tar.gz
ARG HELMFILE_FILE_NAME=helmfile_${HELMFILE_VERSION}_${TARGETOS}_${TARGETARCH}.tar.gz
ARG KUSTOMIZE_VERSION=5.6.0
ARG KUSTOMIZE_FILE_NAME=kustomize_v${KUSTOMIZE_VERSION}_${TARGETOS}_${TARGETARCH}.tar.gz
ARG HELM_DIFF_VERSION=3.9.13
ARG HELM_SECRETS_VERSION=4.6.2
ARG HELM_GIT_VERSION=1.3.0
ARG HELM_WORKING_DIR=/helm-working-dir

LABEL version="${HELMFILE_VERSION}-${HELM_VERSION}"
LABEL maintainer="sakamoto@chatwork.com"

WORKDIR /

USER root
ENV ARGOCD_USER_ID=999
ENV ARGOCD_GROUP_ID=999
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update -qq \
    && apt install --no-install-recommends -y \
      ca-certificates \
      git bash curl jq wget openssh-client unzip \
    && rm -rf /var/lib/apt/lists/* \
    && groupadd -g $ARGOCD_GROUP_ID argocd \
    && useradd -r -u $ARGOCD_USER_ID -g argocd argocd \
    && mkdir -p /home/argocd \
    && mkdir -p $HELM_WORKING_DIR \
    && chown argocd:argocd /home/argocd \
    && chown argocd:0 $HELM_WORKING_DIR \
    && chmod g=u /home/argocd \
    && chmod g=u $HELM_WORKING_DIR

# kubectl
ADD https://dl.k8s.io/release/v${KUBECTL_VERSION}/bin/${TARGETOS}/${TARGETARCH}/kubectl /tmp
RUN mv /tmp/kubectl /usr/local/bin/kubectl \
  && chmod 755 /usr/local/bin/kubectl

# helm
ADD https://get.helm.sh/${HELM_FILE_NAME} /tmp
RUN tar -zxvf /tmp/${HELM_FILE_NAME} -C /tmp \
  && mv /tmp/${TARGETOS}-${TARGETARCH}/helm /usr/local/bin/helm \
  && chmod 755 /usr/local/bin/helm \
  && rm -rf /tmp/*

# kustomize
ADD https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize/v${KUSTOMIZE_VERSION}/${KUSTOMIZE_FILE_NAME} /tmp
RUN tar -zxf /tmp/${KUSTOMIZE_FILE_NAME} -C /tmp \
    && mv /tmp/kustomize /usr/local/bin/kustomize \
    && chmod 755 /usr/local/bin/kustomize \
    && rm -fr /tmp/*

ADD https://github.com/helmfile/helmfile/releases/download/v${HELMFILE_VERSION}/${HELMFILE_FILE_NAME} /tmp

# helmfile
RUN tar -zxvf /tmp/${HELMFILE_FILE_NAME} -C /tmp \
  && mv /tmp/helmfile /usr/local/bin/helmfile \
  && chmod 755 /usr/local/bin/helmfile \
  && rm -rf /tmp/*

# aws
RUN AWS_CLI_ARCH="" \
&& case ${TARGETARCH} in \
  "amd64") AWS_CLI_ARCH=x86_64 ;; \
  "arm64") AWS_CLI_ARCH=aarch64 ;; \
  *) echo "no match PLATFORM"; exit 1 ;; \
esac \
&& echo ${AWS_CLI_ARCH} \
&& cd /tmp \
&& curl "https://awscli.amazonaws.com/awscli-exe-linux-${AWS_CLI_ARCH}.zip" -o "awscliv2.zip" \
&& unzip awscliv2.zip \
&& ./aws/install \
&& cd ${HOME} \
&& rm -rf /tmp/*

# helm plugin
ENV HELM_CACHE_HOME=$HELM_WORKING_DIR/.cache
ENV HELM_CONFIG_HOME=$HELM_WORKING_DIR/.config
ENV HELM_DATA_HOME=$HELM_WORKING_DIR/.local
ENV USER=argocd
USER $ARGOCD_USER_ID

RUN helm plugin install https://github.com/databus23/helm-diff --version v${HELM_DIFF_VERSION} \
    && helm plugin install https://github.com/jkroepke/helm-secrets --version v${HELM_SECRETS_VERSION} \
    && helm plugin install https://github.com/aslafy-z/helm-git.git --version v${HELM_GIT_VERSION}

WORKDIR /home/argocd
ENTRYPOINT ["/usr/local/bin/helmfile"]
