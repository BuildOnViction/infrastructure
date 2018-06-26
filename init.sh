#!/bin/bash

for i in {1..3}; do
  docker run \
    -v $(pwd)/deploy/ressources/password:/tomochain/password \
    -v $(pwd)/deploy/ressources/keystore/:/tomochain/keystore/ \
    tomochain/tomochain:latest \
    account new --password ./password --keystore ./keystore
done
