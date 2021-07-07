FROM docker:20.10.7

ARG GOSS_VERSION="0.3.16"

LABEL version="${GOSS_VERSION}"
LABEL maintainer="shinohara@chatwork.com"

RUN ARCH="$(apk --print-arch)" \
    && case "${ARCH}" in \
        arm64|aarch64) \
            GOSS_URL="https://github.com/aelsabbahy/goss/releases/download/v${GOSS_URL}/goss-linux-arm" \
            ;; \
        amd64|x86_64) \
            GOSS_URL="https://github.com/aelsabbahy/goss/releases/download/v${GOSS_URL}/goss-linux-amd64" \
            ;; \
        *) \
            echo "Unsupported architecture: ${ARCH}" \
            exit 1 \
            ;; \
        esac \
    && apk add --no-cache bash \
    && apk add --no-cache bash \
    && wget $GOSS_URL -O /usr/local/bin/goss \
    && wget "https://github.com/aelsabbahy/goss/releases/download/v${GOSS_URL}/dgoss" -O /usr/local/bin/dgoss \
    && chmod +rx /usr/local/bin/goss /usr/local/bin/dgoss

ENTRYPOINT ["dgoss"]
