FROM docker:20.10.17

ARG GOSS_VERSION=0.4.7

LABEL version="${GOSS_VERSION}"
LABEL maintainer="shinohara@chatwork.com"

ARG TARGETOS
ARG TARGETARCH

RUN GOSS_URL="https://github.com/aelsabbahy/goss/releases/download/v${GOSS_VERSION}/goss-${TARGETOS}-${TARGETARCH}" \
    && apk add --no-cache bash \
    && wget ${GOSS_URL} -O /usr/local/bin/goss \
    && wget "https://github.com/aelsabbahy/goss/releases/download/v${GOSS_VERSION}/dgoss" -O /usr/local/bin/dgoss \
    && chmod +rx /usr/local/bin/goss /usr/local/bin/dgoss

ENTRYPOINT ["dgoss"]
