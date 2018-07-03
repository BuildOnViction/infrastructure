#!/bin/bash
set -x

docker-compose \
  -f deploy/docker-compose.tomochain.yml \
  -f deploy/docker-compose.metrics.yml \
  -f deploy/docker-compose.netstats.yml \
  -f deploy/docker-compose.tomomaster.yml \
  -f deploy/docker-compose.tomoscan.yml \
up -d --build
