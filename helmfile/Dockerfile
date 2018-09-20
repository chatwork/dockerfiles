ARG HELM_VERSION=2.10.0
FROM chatwork/helm:${HELM_VERSION}

ARG HELM_DIFF_VERSION=master
ARG HELM_SECRETS_VERSION=master
ARG HELMFILE_VERSION=0.36.1

LABEL version "${HELMFILE_VERSION}-${HELM_VERSION}"
LABEL maintainer "ozaki@chatwork.com"

WORKDIR /

RUN apk --no-cache add git bash curl

RUN mkdir -p "$(helm home)/plugins" && \
    helm plugin install https://github.com/databus23/helm-diff --version ${HELM_DIFF_VERSION} && \
    helm plugin install https://github.com/futuresimple/helm-secrets --version ${HELM_SECRETS_VERSION}

ADD https://github.com/roboll/helmfile/releases/download/v${HELMFILE_VERSION}/helmfile_linux_amd64 /bin/helmfile
RUN chmod 0755 /bin/helmfile

ENTRYPOINT ["/bin/helmfile"]
