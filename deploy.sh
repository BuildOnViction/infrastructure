#!/bin/bash
docker-compose build
for file in nodes netstats metrics tomomaster tomoscan cd; do
  docker stack deploy -c deploy/${file}.yml localnet
done
