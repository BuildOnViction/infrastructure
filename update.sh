#!/bin/bash -e

if [[ $# -eq 0 ]]; then
  docker-compose build
else
  docker-compose build "$1"
  docker service update "localnet_$1" --force
fi
