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

# boot supervisord
supervisord -c /etc/supervisord.conf
