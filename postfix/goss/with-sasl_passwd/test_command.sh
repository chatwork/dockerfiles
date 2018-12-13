#!/bin/bash

ID=$(docker run -d chatwork/postfix)
IMAGE=chatwork/postfix-sasl_passwd

docker cp /goss/sasl_passwd ${ID}:/etc/postfix/sasl_passwd
docker exec ${ID} chown root:root /etc/postfix/sasl_passwd
docker commit ${ID} ${IMAGE}

/usr/local/bin/dgoss run ${IMAGE}

