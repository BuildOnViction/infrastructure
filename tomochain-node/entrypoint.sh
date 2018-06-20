#!/bin/sh

if [[ -z $IDENTITY ]]; then
  echo "Please, provide the node wallet password via the env var PASSWORD"
  exit
fi
