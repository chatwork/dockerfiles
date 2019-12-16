FROM alpine:3.8

LABEL version="0.1.0"
LABEL maintainer="ozaki@chatwork.com"

RUN apk --no-cache add postfix supervisor rsyslog

COPY files/supervisord.conf /etc/supervisord.conf
COPY files/rsyslog.conf /etc/rsyslog.conf
COPY files/entrypoint.sh /opt/entrypont.sh

ENTRYPOINT ["sh", "/opt/entrypont.sh"]