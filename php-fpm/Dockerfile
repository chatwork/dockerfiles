FROM php:7.1-fpm-alpine

LABEL version="0.1.0"
LABEL maintainer="ozaki@chatwork.com"

RUN \
  # install dependencies
  apk --no-cache add \
    fcgi \
    g++ \
    gcc \
    git \
    gmp-dev \
    libjpeg-turbo-dev \
    libpng-dev \
    libmcrypt-dev \
    make \
    openssh \
    php7-dev \
  # install php extensions
  && docker-php-ext-install -j$(nproc) \
    bcmath \
    gd \
    gmp \
    mcrypt \
    mysqli \
    opcache \
    pdo_mysql \
    zip \
  # install pecl extensions
  && pecl install \
    apcu \
    igbinary \
    redis-4.0.2 \
    grpc-1.11.1 \
    protobuf-3.5.1.1 \
  # enable pecl extensions
  && docker-php-ext-enable \
    apcu \
    igbinary \
    redis
