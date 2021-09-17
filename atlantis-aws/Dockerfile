FROM runatlantis/atlantis:v0.14.0

# atlantis version
LABEL version="0.14.0"
LABEL maintainer="tatsuno@chatwork.com"

# https://github.com/aws/aws-cli/issues/4685
ENV GLIBC_VER=2.34-r0

# https://github.com/runatlantis/atlantis/issues/1605#issuecomment-895087882
RUN curl -sL https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub -o /etc/apk/keys/sgerrand.rsa.pub \
    && curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VER}/glibc-${GLIBC_VER}.apk \
    && curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VER}/glibc-bin-${GLIBC_VER}.apk \
    && curl -sL https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscliv2.zip \
    && apk add --update --no-cache util-linux openssl python3 glibc-${GLIBC_VER}.apk glibc-bin-${GLIBC_VER}.apk \
    && unzip awscliv2.zip && aws/install \
    && rm -rf awscliv2.zip aws glibc-${GLIBC_VER}.apk glibc-bin-${GLIBC_VER}.apk \
        /usr/local/aws-cli/v2/*/dist/aws_completer \
        /usr/local/aws-cli/v2/*/dist/awscli/data/ac.index \
        /usr/local/aws-cli/v2/*/dist/awscli/examples \
        /var/cache/apk/* \
