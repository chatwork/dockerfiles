FROM alpine:3.19
ARG TARGETARCH
ARG KONSTRAINT_VERSION=0.36.0
LABEL version="${KONSTRAINT_VERSION}"
LABEL maintainer="sakamoto@chatwork.com"

ADD https://github.com/plexsystems/konstraint/releases/download/v${KONSTRAINT_VERSION}/konstraint-linux-${TARGETARCH} /usr/local/bin/konstraint

RUN chmod 755 /usr/local/bin/konstraint

ENTRYPOINT ["konstraint"]
