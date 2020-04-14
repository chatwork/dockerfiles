FROM alpine:latest

ARG POSTFIX_EXPORTER_VERSION=0.2.0

LABEL version="${POSTFIX_EXPORTER_VERSION}"
LABEL maintainer="ozaki@chatwork.com"

ADD https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub /etc/apk/keys/sgerrand.rsa.pub
ADD https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.31-r0/glibc-2.31-r0.apk /tmp
RUN apk add --no-cache /tmp/glibc-2.31-r0.apk

ADD https://github.com/kumina/postfix_exporter/releases/download/${POSTFIX_EXPORTER_VERSION}/postfix_exporter /bin
RUN chmod +x /bin/postfix_exporter

ENTRYPOINT ["/bin/postfix_exporter"]
CMD ["--help"]
