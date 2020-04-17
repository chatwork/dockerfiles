FROM chatwork/alpine-sdk:3.10

ARG KUBECTL_VERSION=1.18.1

LABEL version="${KUBECTL_VERSION}"
LABEL maintainer="ozaki@chatwork.com"
LABEL maintainer="sakamoto@chatwork.com"

ADD https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl /usr/local/bin/kubectl

RUN chmod +x /usr/local/bin/kubectl

RUN apk --no-cache add python3 py3-pip groff jq \
    && pip3 install --no-cache-dir --upgrade pip \
    && pip3 install --no-cache-dir awscli

ENTRYPOINT ["/usr/local/bin/kubectl"]
CMD ["help"]
