#!/bin/sh -x

params=""

# file to env
for env in PRIVATE_KEY IP; do
  file=$(eval echo "\$${env}_FILE")
  if [[ -f $file ]] && [[ ! -z $file ]]; then
    echo "Replacing $env by $file"
    export $env=$(cat $file)
  fi
done

# private key
if [[ -z $PRIVATE_KEY ]]; then
  bootnode -genkey bootnode.key $params
else
  echo "$PRIVATE_KEY" > bootnode.key
fi

# dump address
address="enode://$(bootnode -nodekey bootnode.key -writeaddress)@[$(hostname -i)]:30301"

echo "$address" > ./bootnodes/bootnodes

exec bootnode -nodekey bootnode.key $params
