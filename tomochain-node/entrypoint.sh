#!/bin/sh

# constants
DATA_DIR="data"
KEYSTORE_DIR="keystore"
GENESIS_FILE="genesis.json"
GENESIS_PATH="genesis/$GENESIS_FILE"
BOOTNODES_FILE="bootnodes"
BOOTNODES_PATH="bootnodes/$BOOTNODES_FILE"
PASSWORD_FILE="masternode_wallet_password"
PASSWORD_PATH="/run/secrets/$PASSWORD_FILE"

# vars from docker env
# - INDEX (default to 1)
# - IDENTITY (default to unnamed_node)
# - IS_BOOTNODE (default to false)

params=""

# if no blockchain data, init the genesis block
if [[ ! -d $DATA_DIR/tomo ]]; then
  tomo init $GENESIS_PATH --datadir $DATA_DIR 2> /dev/null
fi

# set tomo password param
if [[ -f $PASSWORD_PATH ]]; then
  params="$params --password $PASSWORD_PATH"
else
  echo "Secret [$PASSWORD_FILE] is mendatory. Exiting..."
  exit
fi

# set tomo bootnode param (or dump enode in bootnode file if IS_BOOTNODE)
if [[ "$IS_BOOTNODE" = true ]]; then
  echo "Dumping self enode address to $BOOTNODES_PATH"
  tomo js getenode.js --datadir $DATA_DIR --keystore $KEYSTORE_DIR \
  2> /dev/null \
  | sed "s/::/$(hostname -i)/g"
  > $BOOTNODES_PATH
else
  echo "Adding bootnodes to startup params"
  sleep 10
  params="$params --bootnodes $BOOTNODES_PATH"
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
else
  echo "Your index [$INDEX] does not match the number of accounts [$(echo "$accounts" | wc -l)] . Exiting..."
  exit
fi

set -x
tomo $params \
     --datadir $DATA_DIR \
     --keystore $KEYSTORE_DIR \
     --identity $IDENTITY \
     --networkid 89 \
     --rpc \
     --rpccorsdomain "*" \
     --rpcaddr 0.0.0.0 \
     --rpcport 8545 \
     --rpcvhosts "*" \
     --mine \
     --gasprice "1" \
     --targetgaslimit "420000000"
