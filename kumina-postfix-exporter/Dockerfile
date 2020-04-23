FROM golang:1.13 AS builder

RUN apt-get update -qq \
    && apt-get install -qqy build-essential libsystemd-dev

RUN mkdir -p /go/src/github.com/kumina \
    && git clone --branch fixes-panic-logfilepath-empty --single-branch --depth 1 https://github.com/k-kinzal/postfix_exporter.git /go/src/github.com/kumina/postfix_exporter \
    && cd /go/src/github.com/kumina/postfix_exporter \
    && GO111MODULE=on go build -o /bin/postfix_exporter


FROM alpine:latest

LABEL version="k-kinzal-fixes-panic-logfilepath-empty"
LABEL maintainer="ozaki@chatwork.com"

ADD https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub /etc/apk/keys/sgerrand.rsa.pub
ADD https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.31-r0/glibc-2.31-r0.apk /tmp
RUN apk add --no-cache /tmp/glibc-2.31-r0.apk

COPY --from=builder /bin/postfix_exporter /bin/

ENTRYPOINT ["/bin/postfix_exporter"]
CMD ["--help"]
