FROM alpine/git:1.0.4 as git

ARG VARIANT_VERSION=0.0.8

WORKDIR /

RUN git clone https://github.com/mumoshu/variant.git \
    && cd /variant \
    && git checkout -b tag refs/tags/v$VARIANT_VERSION

FROM golang:1.11.1-alpine as builder

ENV GOOS=linux
ENV GOARCH=amd64

WORKDIR /go/src/github.com/mumoshu/variant

COPY --from=git /variant /go/src/github.com/mumoshu/variant
COPY diff.patch /go/src/github.com/mumoshu/variant/diff.patch

RUN apk add --no-cache bash make git ca-certificates \
    && go get github.com/Sirupsen/logrus \
    && go get github.com/juju/errors \
    && go get github.com/mitchellh/mapstructure \
    && go get github.com/mumoshu/logrus-bunyan-formatter \
    && go get github.com/spf13/cobra \
    && go get github.com/spf13/viper \
    && patch -p1 < diff.patch \
    && make build


FROM alpine:latest

ARG VARIANT_VERSION=0.0.8

LABEL version="${VARIANT_VERSION}"
LABEL maintainer="ozaki@chatwork.com"

COPY --from=builder /go/src/github.com/mumoshu/variant/dist/${VARIANT_VERSION}/var /usr/local/bin/variant

VOLUME ["/variant"]
WORKDIR /variant

ENTRYPOINT ["/usr/local/bin/variant"]
CMD ["--help"]
