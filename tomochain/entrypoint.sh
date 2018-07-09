#!/bin/sh

# vars from docker env
# - IDENTITY (default to unnamed_node)
# - IS_BOOTNODE (default to false)
# - PASSWORD (default to empty)
# - PRIVATE_KEY (default to empty)

# constants
DATA_DIR="data"
KEYSTORE_DIR="keystore"
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

# check if account private key is set
if [[ -z $PRIVATE_KEY ]] || [[ -z $PRIVATE_KEY_FILE ]]; then
  echo "Account private key is mendatory. Exiting..."
else
  if [[ -z $PRIVATE_KEY ]]; then
    $PRIVATE_KEY=$(cat $PRIVATE_KEY_FILE)
  fi
  echo $PRIVATE_KEY > ./private_key
fi

# check if account password is set
if [[ -z $PASSWORD ]] || [[ -z $PASSWORD_FILE ]]; then
  echo "Account password is mendatory. Exiting..."
else
  if [[ -z $PASSWORD ]]; then
    $PASSWORD=$(cat $PASSWORD_FILE)
  fi
  echo $PASSWORD > ./password
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
  tomo  account import ./private_key \
    --password ./password \
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
exec tomo $params \
  --datadir $DATA_DIR \
  --keystore $KEYSTORE_DIR \
  --identity $IDENTITY \
  --password ./password \
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
