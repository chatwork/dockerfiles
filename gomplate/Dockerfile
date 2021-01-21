FROM chatwork/alpine-sdk:3.13

ARG GOMPLATE_VERSION=3.8.0

LABEL version="v${GOMPLATE_VERSION}"
LABEL maintainer="sakamoto@chatwork.com"

ADD https://github.com/hairyhenderson/gomplate/releases/download/v${GOMPLATE_VERSION}/gomplate_linux-amd64 /usr/local/bin/gomplate

RUN chmod 0755 /usr/local/bin/gomplate

ENTRYPOINT ["/usr/local/bin/gomplate"]
CMD ["-h"]
