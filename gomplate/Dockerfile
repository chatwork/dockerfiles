FROM chatwork/alpine-sdk:3.16

ARG TARGETOS
ARG TARGETARCH

ARG GOMPLATE_VERSION=5.0.0

LABEL version="v${GOMPLATE_VERSION}"
LABEL maintainer="sakamoto@chatwork.com"

RUN apk --no-cache upgrade

ADD https://github.com/hairyhenderson/gomplate/releases/download/v${GOMPLATE_VERSION}/gomplate_${TARGETOS}-${TARGETARCH} /usr/local/bin/gomplate

RUN chmod 0755 /usr/local/bin/gomplate

ENTRYPOINT ["/usr/local/bin/gomplate"]
CMD ["-h"]
