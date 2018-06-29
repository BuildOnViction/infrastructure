#!/bin/bash
set -ex

docker volume create keystore
docker volume create genesis
docker run --rm \
  -v $(pwd)/deploy/ressources/password:/build/password \
  -v $(pwd)/deploy/init/init_script.sh:/build/init_script.sh \
  -v $(pwd)/deploy/init/template.json:/build/template.json \
  -v keystore:/build/keystore \
  -v genesis:/build/genesis \
  --entrypoint=/build/init_script.sh \
  tomochain/tomochain:latest
docker stack deploy -c <( docker-compose \
  -f deploy/docker-compose.masternodes.yml \
  -f deploy/docker-compose.metrics.yml \
  -f deploy/docker-compose.netstats.yml \
  -f deploy/docker-compose.tomomaster.yml \
  -f deploy/docker-compose.tomoscan.yml \
  config) localnet
