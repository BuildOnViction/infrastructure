#!/bin/sh

set -x

# constants
DATA_DIR="data"
KEYSTORE_DIR="keystore"
BOOTNODES_FILE="bootnodes"
BOOTNODES_PATH="bootnodes/$BOOTNODES_FILE"
PASSWORD_FILE="MASTERNODE_WALLET_PASSWORD"
PASSWORD_PATH="/run/secrets/$PASSWORD_FILE"

# vars from docker env
# - INDEX (default to 1)
# - IDENTITY (default to unnamed_node)
# - IS_BOOTNODE (default to false)

# set tomo default params
params="--datadir $DATA_DIR "
params="$params --keystore $KEYSTORE_DIR"
params="$params --identity $IDENTITY"
params="$params --networkid 89"
params="$params --rpc"
params="$params --rpccorsdomain '*'"
params="$params --rpcaddr 0.0.0.0"
params="$params --rpcport 8545"
params="$params --rpcvhosts '*'"
params="$params --mine"
params="$params --gasprice '1'"
params="$params --targetgaslimit '420000000'"

# set tomo password param
if [[ -f $PASSWORD_PATH ]]; then
  params="$params --password $PASSWORD_PATH"
else
  echo "Secret [$PASSWORD_FILE] is mendatory. Exiting..."
  exit
fi

# set tomo bootnode param (or dump enode in bootnode file if IS_BOOTNODE)
if [[ "$IS_BOOTNODE" = true ]]; then
  tomo js getenode.js --datadir $DATA_DIR --keystore $KEYSTORE_DIR \
  | sed "s/::/$(hostname -i)/g"
  > $BOOTNODES_PATH
else
  sleep 10
  params="$params --bootnodes $BOOTNODES_PATH"
fi

# set tomo unlock param (the account to use)
accounts=$(tomo account list --datadir $DATA_DIR  --keystore $KEYSTORE_DIR)
if [[ $INDEX -le $(echo $accounts | wc -l) ]]; then
  account=$(
    tomo account list --datadir $DATA_DIR  --keystore $KEYSTORE_DIR \
    | head -n $INDEX \
    | tail -n 1 \
    | cut -d"{" -f 2 | cut -d"}" -f 1
  )
fi


tomo $params
