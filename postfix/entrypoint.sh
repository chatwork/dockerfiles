#!/bin/bash

set -e

# generate /etc/postfix/aliases
postalias /etc/postfix/aliases

# generate /etc/postfix/sasl_passwd.db
if [[ -f /etc/postfix/sasl_passwd ]]; then
    postmap /etc/postfix/sasl_passwd
fi
# generate /etc/postfix/sender_dependent_relayhost.db
if [[ -f /etc/postfix/sender_dependent_relayhost ]]; then
    postmap /etc/postfix/sender_dependent_relayhost
fi

postconf maillog_file=/dev/stdout
postfix start-fg "$@"
