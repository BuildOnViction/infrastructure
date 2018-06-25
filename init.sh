#!/bin/bash

for i in {1..3}; do
  docker run -v $(pwd)/password:/tomochain/password tomochain/tomochain:latest account new --password ./password --keystore ./tomochain/keystore
done

docker run
