ARG FLUENTBIT_VERSION="{{ .fluentbit_version }}"
ARG FLUENTBIT_SUFFIX

FROM golang:1.17-buster AS amazon-cloudwatch-logs-for-fluent-bit

ARG FLUENTBIT_CLOUDWATCH_LOGS_VERSION="{{ .fluentbit_cloudwatch_version }}"

ENV CGO_ENABLED=1
ENV GOOS=linux
ENV GOARCH=amd64
ENV GOPATH=/go
ENV GO111MODULE=on

RUN go get -u golang.org/x/lint/golint \
    && git clone --branch v${FLUENTBIT_CLOUDWATCH_LOGS_VERSION} --single-branch https://github.com/aws/amazon-cloudwatch-logs-for-fluent-bit.git /go/src/github.com/aws/amazon-cloudwatch-logs-for-fluent-bit \
    && cd /go/src/github.com/aws/amazon-cloudwatch-logs-for-fluent-bit \
    && make build

FROM fluent/fluent-bit:${FLUENTBIT_VERSION}${FLUENTBIT_SUFFIX}

ARG FLUENTBIT_VERSION="{{ .fluentbit_version }}"
ARG FLUENTBIT_CLOUDWATCH_LOGS_VERSION="{{ .fluentbit_cloudwatch_version }}"

LABEL version="${FLUENTBIT_VERSION}-${FLUENTBIT_CLOUDWATCH_LOGS_VERSION}"
LABEL maintainer="ozaki@chatwork.com"

COPY --from=amazon-cloudwatch-logs-for-fluent-bit /go/src/github.com/aws/amazon-cloudwatch-logs-for-fluent-bit/bin/cloudwatch.so /usr/lib/x86_64-linux-gnu/

EXPOSE 2020

CMD ["/fluent-bit/bin/fluent-bit", "-c", "/fluent-bit/etc/fluent-bit.conf"]
