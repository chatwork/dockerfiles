FROM alpine:3.11

LABEL version="3.4.8"
LABEL maintainer="ozaki@chatwork.com"

RUN apk --no-cache add postfix

COPY main.cf /etc/postfix/main.cf
COPY entrypoint.sh /entrypont.sh

ENTRYPOINT ["sh", "/entrypont.sh"]