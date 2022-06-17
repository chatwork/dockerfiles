FROM amazon/aws-cli:latest

ARG KUBECTL_VERSION=1.21.14

LABEL version="${KUBECTL_VERSION}"
LABEL maintainer="ozaki@chatwork.com"
LABEL maintainer="sakamoto@chatwork.com"

ADD https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl /usr/local/bin/kubectl

RUN chmod +x /usr/local/bin/kubectl

RUN yum install jq bash tar gzip unzip curl wget -y \
    && yum clean all \
    && rm -rf /var/cache/yum/*

ENTRYPOINT ["/usr/local/bin/kubectl"]
CMD ["help"]
