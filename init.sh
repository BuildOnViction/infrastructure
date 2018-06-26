#!/bin/bash
set -ex

chmod +x ./deploy/init/init_script.sh
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
