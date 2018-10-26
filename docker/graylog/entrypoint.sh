#!/usr/bin/env bash

if [[ ! -z $GRAYLOG_PASSWORD_SECRET_FILE ]]; then
  export GRAYLOG_PASSWORD_SECRET=$(cat $GRAYLOG_PASSWORD_SECRET_FILE)
fi

if [[ ! -z $GRAYLOG_ROOT_PASSWORD_SHA2_FILE ]]; then
  export GRAYLOG_ROOT_PASSWORD_SHA2=$(cat $GRAYLOG_ROOT_PASSWORD_SHA2_FILE)
fi

exec /docker-entrypoint.sh "$@"
