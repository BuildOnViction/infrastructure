#!/bin/sh

if [[ ! -z $WS_SECRET_FILE ]]; then
  export WS_SECRET=$(cat $WS_SECRET_FILE)
fi

exec pm2 start --no-daemon app.json
