FROM chatwork/alpine-sdk:3.15

LABEL version="3.6.3"
LABEL maintainer="ozaki@chatwork.com"
LABEL maintainer="sakamoto@chatwork.com"

RUN apk --no-cache add \
  postfix \
  ca-certificates \
  cyrus-sasl-login \
  libsasl \
  cyrus-sasl \
  cyrus-sasl-crammd5 \
  postfix-pcre

COPY main.cf /etc/postfix/main.cf
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["sh", "/entrypoint.sh"]
