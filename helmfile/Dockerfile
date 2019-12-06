ARG HELMFILE_VERSION=0.94.1

FROM quay.io/roboll/helmfile:helm3-v${HELMFILE_VERSION}

ARG HELMFILE_VERSION=0.94.1
ARG HELM_X_VERSION=0.7.2

LABEL version="${HELMFILE_VERSION}"
LABEL maintainer="ozaki@chatwork.com"
LABEL maintainer="sakamoto@chatwork.com"

WORKDIR /

RUN helm plugin install https://github.com/mumoshu/helm-x --version v${HELM_X_VERSION}

RUN apk --no-cache add python3 py3-pip groff jq \
    && pip3 install --no-cache-dir --upgrade pip \
    && pip3 install --no-cache-dir awscli

ENTRYPOINT ["/usr/local/bin/helmfile"]
