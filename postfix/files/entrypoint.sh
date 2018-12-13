#!/bin/bash

set -e

# generate mail spool directory
mkdir -p /var/spool/postfix
chown root /var/spool/postfix

# generate pid directory
mkdir -p /var/spool/postfix/pid
chown root /var/spool/postfix/pid

# generate /etc/postfix/aliases
postalias /etc/postfix/aliases

# generate /etc/postfix/sasl_passwd.db
if [[ -f /etc/postfix/sasl_passwd ]]; then
    postmap /etc/postfix/sasl_passwd
fi

# boot supervisord
supervisord -c /etc/supervisord.conf
