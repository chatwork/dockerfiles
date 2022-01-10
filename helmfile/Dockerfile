ARG HELMFILE_VERSION=0.143.0

FROM quay.io/roboll/helmfile:v${HELMFILE_VERSION}

ARG HELMFILE_VERSION=0.143.0
ARG HELM_X_VERSION=0.8.1
LABEL version="${HELMFILE_VERSION}"
LABEL maintainer="ozaki@chatwork.com"
LABEL maintainer="sakamoto@chatwork.com"

WORKDIR /

RUN helm plugin install https://github.com/mumoshu/helm-x --version v${HELM_X_VERSION}

RUN apk --no-cache add python3 py3-pip groff jq \
    && pip3 install --no-cache-dir --upgrade pip \
    && pip3 install --no-cache-dir awscli

ENTRYPOINT ["/usr/local/bin/helmfile"]
