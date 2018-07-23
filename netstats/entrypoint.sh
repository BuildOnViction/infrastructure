#!/bin/sh

if [[ ! -z $WS_SECRET_FILE ]]; then
  export WS_SECRET=$(cat $WS_SECRET_FILE)
fi

exec npm start
