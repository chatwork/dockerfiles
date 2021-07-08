FROM docker:20.10.7

ARG GOSS_VERSION=0.3.16

LABEL version="${GOSS_VERSION}"
LABEL maintainer="shinohara@chatwork.com"

RUN apk add --no-cache bash \
    && wget "https://github.com/aelsabbahy/goss/releases/download/v${GOSS_VERSION}/goss-linux-amd64" -O /usr/local/bin/goss \
    && wget "https://github.com/aelsabbahy/goss/releases/download/v${GOSS_VERSION}/dgoss" -O /usr/local/bin/dgoss \
    && chmod +rx /usr/local/bin/goss /usr/local/bin/dgoss

ENTRYPOINT ["dgoss"]
