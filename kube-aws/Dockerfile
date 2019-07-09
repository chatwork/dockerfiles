FROM alpine/git:1.0.4 as git

ARG KUBEAWS_VERSION=v0.14.X
#if you setting kubeaws-version to commit hash, you set ARG KUBEAWS_HASH=a09fae46c4b97578acbfcb9de4eeb87e8f1ae0fb
ARG KUBEAWS_HASH=97bd3fa6b12d6a67cba5e2b7aa779b86df9ff4a2

WORKDIR /

RUN git clone https://github.com/kubernetes-incubator/kube-aws.git\
    && cd /kube-aws \
    && git checkout -b tag refs/tags/$KUBEAWS_VERSION || git checkout $(echo $KUBEAWS_HASH) -b $KUBEAWS_VERSION

FROM instrumentisto/dep:0.5.0 as dep

WORKDIR /go/src/github.com/kubernetes-incubator/kube-aws

COPY --from=git /kube-aws /go/src/github.com/kubernetes-incubator/kube-aws

RUN dep ensure

FROM golang:1.11.1-alpine as builder

ENV GOOS=linux
ENV GOARCH=amd64

COPY --from=dep /go/src/github.com/kubernetes-incubator/kube-aws /go/src/github.com/kubernetes-incubator/kube-aws
WORKDIR /go/src/github.com/kubernetes-incubator/kube-aws
RUN apk add --no-cache bash gcc libc-dev make git ca-certificates && make build

FROM alpine:3.10.0

ARG KUBEAWS_VERSION=v0.14.X
#ARG KUBEAWS_HASH=-a09fae46c4b97578acbfcb9de4eeb87e8f1ae0fb
ARG KUBEAWS_HASH=-97bd3fa6b12d6a67cba5e2b7aa779b86df9ff4a2

LABEL version="${KUBEAWS_VERSION}${KUBEAWS_HASH}"
LABEL maintainer="sakamoto@chatwork.com"

RUN apk add --no-cache ca-certificates
COPY --from=builder /go/src/github.com/kubernetes-incubator/kube-aws/bin/kube-aws /usr/local/bin/kube-aws

VOLUME ["/kube-aws"]
WORKDIR /kube-aws

ENTRYPOINT ["/usr/local/bin/kube-aws"]
CMD ["help"]
