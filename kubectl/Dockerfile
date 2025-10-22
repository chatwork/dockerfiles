FROM amazon/aws-cli:latest

ARG KUBECTL_VERSION=1.31.0
ARG TARGETOS
ARG TARGETARCH

LABEL version="${KUBECTL_VERSION}"
LABEL maintainer="ozaki@chatwork.com"
LABEL maintainer="sakamoto@chatwork.com"

ADD https://dl.k8s.io/release/v${KUBECTL_VERSION}/bin/${TARGETOS}/${TARGETARCH}/kubectl /usr/local/bin/kubectl

RUN chmod +x /usr/local/bin/kubectl

RUN yum update -y \
    && yum upgrade -y \
    && yum install jq bash tar gzip unzip wget -y \
    && yum clean all \
    && rm -rf /var/cache/yum/*

ENTRYPOINT ["/usr/local/bin/kubectl"]
CMD ["help"]
