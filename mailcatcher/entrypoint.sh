#!/bin/sh

exec /usr/local/bundle/bin/mailcatcher -f --no-quit --ip=0.0.0.0 "$@"

