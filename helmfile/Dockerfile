FROM chatwork/alpine-sdk:3.10

ARG KUBECTL_VERSION=1.16.2
ARG HELM_VERSION=2.15.2
ARG HELM_DIFF_VERSION=2.11.0+5
ARG HELM_SECRETS_VERSION=master
ARG HELM_IMPORT_VERSION=0.2.1
ARG HELM_TILLER_VERSION=0.6.7
ARG HELM_GIT_VERSION=0.4.2
ARG HELM_X_VERSION=0.7.2
ARG HELMFILE_VERSION=0.90.0
ARG EKS_VERSION=1.13.7
ENV HELM_FILE_NAME helm-v${HELM_VERSION}-linux-amd64.tar.gz

LABEL version="${HELMFILE_VERSION}-${HELM_VERSION}-${KUBECTL_VERSION}"
LABEL maintainer="ozaki@chatwork.com"
LABEL maintainer="sakamoto@chatwork.com"

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
    helm plugin install https://github.com/k-kinzal/helm-import --version v${HELM_IMPORT_VERSION}  && \
    helm plugin install https://github.com/aslafy-z/helm-git.git --version v${HELM_GIT_VERSION}  && \
    helm plugin install https://github.com/databus23/helm-diff --version v${HELM_DIFF_VERSION} && \
    helm plugin install https://github.com/futuresimple/helm-secrets --version ${HELM_SECRETS_VERSION} && \
    helm plugin install https://github.com/rimusz/helm-tiller --version v${HELM_TILLER_VERSION} && \
    helm plugin install https://github.com/mumoshu/helm-x --version v${HELM_X_VERSION} && \
    helm tiller install

RUN curl -o /bin/aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/${EKS_VERSION}/2019-06-11/bin/linux/amd64/aws-iam-authenticator && \
    chmod +x /bin/aws-iam-authenticator

ADD https://github.com/roboll/helmfile/releases/download/v${HELMFILE_VERSION}/helmfile_linux_amd64 /bin/helmfile
RUN chmod 0755 /bin/helmfile

ENTRYPOINT ["/bin/helmfile"]
