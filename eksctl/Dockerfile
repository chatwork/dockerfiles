FROM alpine:edge as downloads
WORKDIR /downloads

ARG EKSCTL_VERSION=0.11.0
LABEL version="${EKSCTL_VERSION}"
LABEL maintainer="sakamoto@chatwork.com"

RUN wget https://github.com/weaveworks/eksctl/releases/download/${EKSCTL_VERSION}/eksctl_Linux_amd64.tar.gz \
    && tar zxvf eksctl_Linux_amd64.tar.gz

FROM chatwork/aws:latest
COPY --from=downloads  /downloads/eksctl /usr/bin
RUN chmod +x /usr/bin/eksctl

ENTRYPOINT ["/usr/bin/eksctl"]
CMD ["help"]
