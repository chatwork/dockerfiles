FROM alpine:edge as downloads
WORKDIR /downloads

ARG EKSCTL_VERSION=0.14.0
ARG KUBECTL_VERSION=1.15.6
LABEL version="${EKSCTL_VERSION}"

RUN wget -O - https://github.com/weaveworks/eksctl/releases/download/${EKSCTL_VERSION}/eksctl_Linux_amd64.tar.gz | tar zxvf -

RUN wget https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl

FROM chatwork/aws:latest

ARG EKSCTL_VERSION=0.14.0
LABEL version="${EKSCTL_VERSION}"
LABEL maintainer="sakamoto@chatwork.com"

COPY --from=downloads  /downloads/eksctl /usr/local/bin
COPY --from=downloads  /downloads/kubectl /usr/local/bin

RUN chmod +x /usr/local/bin/eksctl
RUN chmod +x /usr/local/bin/kubectl
RUN yum install -y openssh-clients \
    && yum clean all \
    && rm -rf /var/cache/yum/* \

ENTRYPOINT ["/usr/local/bin/eksctl"]
CMD ["help"]
