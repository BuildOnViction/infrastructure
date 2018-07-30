#!/bin/bash

for file in nodes netstats metrics tomomaster tomoscan proxy cd; do
  docker stack deploy -c deploy/${file}.yml devnet
done
