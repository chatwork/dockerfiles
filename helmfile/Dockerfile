FROM amazon/aws-cli:latest

ARG TARGETOS
ARG TARGETARCH

ARG KUBECTL_VERSION=1.28.7
ARG HELMFILE_VERSION=0.162.0
ARG HELM_VERSION=3.14.2
ARG HELM_FILE_NAME=helm-v${HELM_VERSION}-${TARGETOS}-${TARGETARCH}.tar.gz
ARG HELMFILE_FILE_NAME=helmfile_${HELMFILE_VERSION}_${TARGETOS}_${TARGETARCH}.tar.gz
ARG KUSTOMIZE_VERSION=4.5.7
ARG KUSTOMIZE_FILE_NAME=kustomize_v${KUSTOMIZE_VERSION}_${TARGETOS}_${TARGETARCH}.tar.gz
ARG HELM_DIFF_VERSION=3.8.1
ARG HELM_SECRETS_VERSION=4.1.1
ARG HELM_GIT_VERSION=0.14.0

LABEL version="${HELMFILE_VERSION}-${HELM_VERSION}"
LABEL maintainer="sakamoto@chatwork.com"
LABEL maintainer="ozaki@chatwork.com"

WORKDIR /

RUN yum update -y \
    && yum upgrade -y \
    && yum install jq bash tar gzip unzip git curl wget -y \
    && yum clean all \
    && rm -rf /var/cache/yum/*

ADD https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/${TARGETOS}/${TARGETARCH}/kubectl /tmp
RUN mv /tmp/kubectl /usr/local/bin/kubectl \
  && chmod 755 /usr/local/bin/kubectl

ADD https://get.helm.sh/${HELM_FILE_NAME} /tmp
RUN tar -zxvf /tmp/${HELM_FILE_NAME} -C /tmp \
  && mv /tmp/${TARGETOS}-${TARGETARCH}/helm /usr/local/bin/helm \
  && chmod 755 /usr/local/bin/helm \
  && rm -rf /tmp/*

ADD https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize/v${KUSTOMIZE_VERSION}/${KUSTOMIZE_FILE_NAME} /tmp
RUN tar -zxf /tmp/${KUSTOMIZE_FILE_NAME} -C /tmp \
    && mv /tmp/kustomize /usr/local/bin/kustomize \
    && chmod 755 /usr/local/bin/kustomize \
    && rm -fr /tmp/*

ADD https://github.com/helmfile/helmfile/releases/download/v${HELMFILE_VERSION}/${HELMFILE_FILE_NAME} /tmp

RUN tar -zxvf /tmp/${HELMFILE_FILE_NAME} -C /tmp \
  && mv /tmp/helmfile /usr/local/bin/helmfile \
  && chmod 755 /usr/local/bin/helmfile \
  && rm -rf /tmp/*

RUN helm plugin install https://github.com/databus23/helm-diff --version v${HELM_DIFF_VERSION} \
    && helm plugin install https://github.com/jkroepke/helm-secrets --version v${HELM_SECRETS_VERSION} \
    && helm plugin install https://github.com/aslafy-z/helm-git.git --version v${HELM_GIT_VERSION}

ENTRYPOINT ["/usr/local/bin/helmfile"]
