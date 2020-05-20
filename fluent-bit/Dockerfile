ARG FLUENTBIT_VERSION="1.4.4"
ARG FLUENTBIT_SUFFIX


FROM golang:1.14.0-buster AS fluent-bit-go-s3

ARG FLUENTBIT_GO_S3_VERSION="0.7.2"

ENV CGO_ENABLED=1
ENV GOOS=linux
ENV GOARCH=amd64
ENV GOPATH=/go

RUN mkdir -p /go/src/github.com/cosmo0920 \
    && git clone --branch v${FLUENTBIT_GO_S3_VERSION} --single-branch https://github.com/cosmo0920/fluent-bit-go-s3.git /go/src/github.com/cosmo0920/fluent-bit-go-s3 \
    && cd /go/src/github.com/cosmo0920/fluent-bit-go-s3 \
    && make build


FROM golang:1.14.0-buster AS amazon-cloudwatch-logs-for-fluent-bit

ARG FLUENTBIT_CLOUDWATCH_LOGS_VERSION="1.2.0"

ENV CGO_ENABLED=1
ENV GOOS=linux
ENV GOARCH=amd64
ENV GOPATH=/go

RUN go get -u golang.org/x/lint/golint \
    && mkdir -p /go/src/github.com/cosmo0920 \
    && git clone --branch v${FLUENTBIT_CLOUDWATCH_LOGS_VERSION} --single-branch https://github.com/aws/amazon-cloudwatch-logs-for-fluent-bit.git /go/src/github.com/aws/amazon-cloudwatch-logs-for-fluent-bit \
    && cd /go/src/github.com/aws/amazon-cloudwatch-logs-for-fluent-bit \
    && make build


FROM fluent/fluent-bit:${FLUENTBIT_VERSION}${FLUENTBIT_SUFFIX}

ARG FLUENTBIT_VERSION="1.4.4"
ARG FLUENTBIT_GO_S3_VERSION="0.7.2"
ARG FLUENTBIT_CLOUDWATCH_LOGS_VERSION="1.2.0"

LABEL version="${FLUENTBIT_VERSION}-${FLUENTBIT_GO_S3_VERSION}-${FLUENTBIT_CLOUDWATCH_LOGS_VERSION}"
LABEL maintainer="ozaki@chatwork.com"

COPY --from=fluent-bit-go-s3 /go/src/github.com/cosmo0920/fluent-bit-go-s3/out_s3.so /usr/lib/x86_64-linux-gnu/
COPY --from=amazon-cloudwatch-logs-for-fluent-bit /go/src/github.com/aws/amazon-cloudwatch-logs-for-fluent-bit/bin/cloudwatch.so /usr/lib/x86_64-linux-gnu/

EXPOSE 2020

CMD ["/fluent-bit/bin/fluent-bit", "-c", "/fluent-bit/etc/fluent-bit.conf"]