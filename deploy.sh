#!/bin/bash

for file in nodes netstats metrics tomomaster tomoscan proxy; do
  docker stack deploy -c deploy/${file}.yml devnet
done
