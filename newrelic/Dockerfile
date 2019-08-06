FROM php:7.3

LABEL version="0.0.0"
LABEL maintainer="niinuma@chatwork.com"

ARG LICENSE_KEY=${LICENSE_KEY}
ARG APPLICATION_NAME=${APPLICATION_NAME}
ARG URL=https://download.newrelic.com/php_agent/release/newrelic-php5-8.7.0.242-linux.tar.gz

RUN \
  curl -L ${URL} | tar -C /tmp -zx && \
   export NR_INSTALL_USE_CP_NOT_LN=1 && \
    export NR_INSTALL_SILENT=1 && \
     /tmp/newrelic-php5-*/newrelic-install install && \
      rm -rf /tmp/newrelic-php5-* /tmp/nrinstall* && \
        sed -i -e 's/"REPLACE_WITH_REAL_KEY"/"${LICENSE_KEY}"/' \
     -e 's/newrelic.appname = "PHP Application"/newrelic.appname = "${APPLICATION_NAME}"/' \
         /usr/local/etc/php/conf.d/newrelic.ini