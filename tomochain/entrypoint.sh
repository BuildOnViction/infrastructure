#!/bin/sh

# constants
DATA_DIR="data"
KEYSTORE_DIR="keystore"
GENESIS_FILE="genesis.json"
GENESIS_PATH="genesis/$GENESIS_FILE"
BOOTNODES_FILE="bootnodes"
BOOTNODES_PATH="bootnodes/$BOOTNODES_FILE"

# vars from docker env
# - INDEX (default to 1)
# - IDENTITY (default to unnamed_node)
# - IS_BOOTNODE (default to false)

params=""

# if no blockchain data, init the genesis block
if [[ ! -d $DATA_DIR/tomo ]]; then
  echo "No blockchain data, creating genesis block."
  tomo init $GENESIS_PATH --datadir $DATA_DIR 2> /dev/null
fi

# set tomo password param
if [[ ! -f password ]]; then
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
  while [[ -z $BOOTNODES_PATH ]]; do
    echo "Adding bootnodes to startup params. Will retry if empty"
    sleep 10
    params="$params --bootnodes $(cat $BOOTNODES_PATH | head -n 1)"
  done
fi

# set tomo unlock param (the account to use)
accounts=$(tomo account list --datadir $DATA_DIR  --keystore $KEYSTORE_DIR)
echo "Accounts:"
echo $accounts
if [[ $INDEX -le $(echo "$accounts" | wc -l) && $INDEX -ge 1 ]]; then
  account=$(
    tomo account list --datadir $DATA_DIR  --keystore $KEYSTORE_DIR \
    2> /dev/null \
    | head -n $INDEX \
    | tail -n 1 \
    | cut -d"{" -f 2 | cut -d"}" -f 1
  )
  echo "Using account $account"
  params="$params --unlock $account"
  params="$params --etherbase $account"
else
  echo "Your index [$INDEX] does not match the number of accounts [$(echo "$accounts" | wc -l)] . Exiting..."
  exit
fi

set -x
tomo $params \
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
