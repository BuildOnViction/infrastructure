#!/bin/sh
set -x
for i in 1 2 3; do
  tomo account new --password /build/password --keystore /build/keystore
done
accounts=$(
  tomo account list --keystore /build/keystore \
  | cut -d"{" -f 2 | cut -d"}" -f 1 \
  | awk '{print}' ORS=''
)
sed "s/:wallet:/$accounts/g" /build/template.json > /build/genesis/genesis.json
