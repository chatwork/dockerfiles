#!/bin/sh
set -e

if [ -z "$CHATWORK_TOKEN" ]; then
  echo "should set CHATWORK_TOKEN for environment variables" 1>&2;
  exit 1;
fi

if [ -z "$ROOM_ID" ]; then
  echo "should set ROOM_ID for environment variables" 1>&2;
  exit 1;
fi

exec curl -sS -X POST -H "X-ChatWorkToken: ${CHATWORK_TOKEN}" "https://api.chatwork.com/v2/rooms/${ROOM_ID}/messages" -d "body=$@"
