#!/bin/bash
set -ex

docker-compose \
  -f deploy/docker-compose.masternodes.yml \
  -f deploy/docker-compose.metrics.yml \
  -f deploy/docker-compose.netstats.yml \
  -f deploy/docker-compose.tomomaster.yml \
  -f deploy/docker-compose.tomoscan.yml \
  build
docker-compose \
  -f deploy/docker-compose.masternodes.yml \
  -f deploy/docker-compose.metrics.yml \
  -f deploy/docker-compose.netstats.yml \
  -f deploy/docker-compose.tomomaster.yml \
  -f deploy/docker-compose.tomoscan.yml \
  up -d
