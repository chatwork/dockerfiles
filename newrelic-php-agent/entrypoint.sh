#!/bin/sh
sed -i "s/^newrelic.license =.*$/newrelic.license = \"${LICENSE_KEY}\"/" /usr/local/etc/php/conf.d/newrelic.ini
sed -i "s/^newrelic.appname =.*$/newrelic.appname = \"${APPLICATION_NAME}\"/" /usr/local/etc/php/conf.d/newrelic.ini
exec /usr/local/bin/newrelic-daemon -f --port ${NR_PORT}