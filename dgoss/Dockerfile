FROM docker:20.10.7

ENV GOSS_VERSION=v0.3.16

RUN ARCH="$(apk --print-arch)" \
    && case "${ARCH}" in \
        arm64|aarch64) \
            GOSS_URL="https://github.com/aelsabbahy/goss/releases/download/${GOSS_VERSION}/goss-linux-arm" \
            ;; \
        amd64|x86_64) \
            GOSS_URL="https://github.com/aelsabbahy/goss/releases/download/${GOSS_VERSION}/goss-linux-amd64" \
            ;; \
        *) \
            echo "Unsupported architecture: ${ARCH}" \
            exit 1 \
            ;; \
        esac \
    && apk add --no-cache bash \
    && apk add --no-cache bash \
    && wget $GOSS_URL -O /usr/local/bin/goss \
    && wget https://github.com/aelsabbahy/goss/releases/download/${GOSS_VERSION}/dgoss -O /usr/local/bin/dgoss \
    && chmod +rx /usr/local/bin/goss /usr/local/bin/dgoss

ENTRYPOINT ["dgoss"]
