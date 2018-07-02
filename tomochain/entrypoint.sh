#!/bin/sh

# vars from docker env
# - IDENTITY (default to unnamed_node)
# - IS_BOOTNODE (default to false)

# constants
DATA_DIR="data"
KEYSTORE_DIR="keystore"
PASSWORD_FILE="password_$IDENTITY"
PASSWORD_PATH="/run/secrets/$PASSWORD_FILE"
KEY_FILE="key_$IDENTITY"
KEY_PATH="/run/secrets/$KEY_FILE"
GENESIS_FILE="genesis.json"
GENESIS_PATH="genesis/$GENESIS_FILE"
BOOTNODES_FILE="bootnodes"
BOOTNODES_PATH="bootnodes/$BOOTNODES_FILE"

params=""

# if no blockchain data, init the genesis block
if [[ ! -d $DATA_DIR/tomo ]]; then
  echo "No blockchain data, creating genesis block."
  tomo init $GENESIS_PATH --datadir $DATA_DIR 2> /dev/null
fi

# set tomo password param
if [[ ! -f $PASSWORD_PATH ]]; then
  echo "Password file is mendatory. Exiting..."
fi

# set tomo bootnode param (or dump enode in bootnode file if IS_BOOTNODE)
if [[ "$IS_BOOTNODE" = true ]]; then
  echo "Dumping self enode address to $BOOTNODES_PATH"
  tomo js getenode.js --datadir $DATA_DIR --keystore $KEYSTORE_DIR \
  2> /dev/null \
  | sed "s/::/$(hostname -i)/g" \
  > $BOOTNODES_PATH
else
  echo "Adding bootnodes to startup params. Will retry if empty"
  while true ; do
    if [[ -f $BOOTNODES_PATH ]] && [[ $(grep -e enode $BOOTNODES_PATH) ]]; then
      echo "Found bootnodes $(cat $BOOTNODES_PATH)"
      break
    fi
    echo "No bootnodes found"
    sleep 5
  done
  params="$params --bootnodes $(cat $BOOTNODES_PATH | head -n 1)"
fi

# if the keystore is empty, import
if [[ "$(ls -A $KEYSTORE_DIR)" ]]; then
  tomo  account import $KEY_PATH \
    --password $PASSWORD_PATH \
    --datadir $DATA_DIR \
    --keystore $KEYSTORE_DIR
  account=$(
    tomo account list --datadir $DATA_DIR  --keystore $KEYSTORE_DIR \
    2> /dev/null \
    | head -n 1 \
    | cut -d"{" -f 2 | cut -d"}" -f 1
  )
  echo "Using account $account"
  params="$params --unlock $account"
fi

set -x
tomo $params \
     --datadir $DATA_DIR \
     --keystore $KEYSTORE_DIR \
     --identity $IDENTITY \
     --password $PASSWORD_PATH \
     --networkid 89 \
     --rpc \
     --rpccorsdomain "*" \
     --rpcaddr 0.0.0.0 \
     --rpcport 8545 \
     --rpcvhosts "*" \
     --ws \
     --wsaddr 0.0.0.0 \
     --wsport 8546 \
     --wsorigins "*" \
     --mine \
     --gasprice "1" \
     --targetgaslimit "420000000"
