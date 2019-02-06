FROM php:7.1-cli-alpine

LABEL version="0.0.0"

RUN apk --no-cache add openjdk8-jre-base libc6-compat php7-dev g++ gcc make

RUN pecl install swoole \
    && echo "extension=swoole.so" > /usr/local/etc/php/conf.d/swoole.ini
