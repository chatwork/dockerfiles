#!/bin/sh

# Delete an empty AWS environment variable
unset `env | grep '^AWS_.*=$' | sed 's/=$//'`

exec /usr/local/bin/aws "$@"
