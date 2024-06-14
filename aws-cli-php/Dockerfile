ARG AWS_CLI_VERSION=2.3.5
ARG PHP_VERSION=8.0

FROM amazon/aws-cli:${AWS_CLI_VERSION}

ARG PHP_VERSION
ARG AWS_CLI_VERSION

LABEL version="${AWS_CLI_VERSION}-${PHP_VERSION}"
LABEL aws_cli_version="${AWS_CLI_VERSION}"
LABEL php_version="${PHP_VERSION}"
LABEL maintainer="shinohara@chatwork.com"

RUN amazon-linux-extras enable php${PHP_VERSION} \
    && yum install -y  \
        jq \
        git \
        php \
        php-mbstring \
        php-gmp \
        php-mcrypt \
        php-xml \
    && yum clean all

ENTRYPOINT ['/usr/local/bin/aws']
