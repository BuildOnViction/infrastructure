#!/bin/sh -x

# vars from docker env
# - IDENTITY (default to 'unnamed_node')
# - PASSWORD (default to empty)
# - PRIVATE_KEY (default to empty)
# - BOOTNODES (default to empty)
# - WS_SECRET (default to empty)
# - NETSTATS_HOST (default to 'netstats-server:3000')
# - NETSTATS_PORT (default to 'netstats-server:3000')

# constants
DATA_DIR="data"
KEYSTORE_DIR="keystore"
GENESIS_FILE="genesis.json"
GENESIS_PATH="genesis/$GENESIS_FILE"
BOOTNODES_FILE="bootnodes"
BOOTNODES_PATH="bootnodes/$BOOTNODES_FILE"

params=""

# file to env
for env in IDENTITY PASSWORD PRIVATE_KEY BOOTNODES WS_SECRET NETSTATS_HOST \
           NETSTATS_PORT; do
  file=$(eval echo "\$${env}_FILE")
  if [[ -f $file ]] && [[ ! -z $file ]]; then
    echo "Replacing $env by $file"
    export $env=$(cat $file)
  fi
done

# data dir
if [[ ! -d $DATA_DIR/tomo ]]; then
  echo "No blockchain data, creating genesis block."
  tomo init $GENESIS_PATH --datadir $DATA_DIR 2> /dev/null
fi

# password file
if [[ ! -f ./password ]]; then
  if [[ ! -z $PASSWORD ]]; then
    echo "Password env is set. Writing into file."
    echo "$PASSWORD" > ./password
  else
    echo "No password set (or empty), generating a new one"
    $(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-32} > password)
  fi
fi

# private key
if [[ "$(ls -A $KEYSTORE_DIR)" ]]; then
  if [[ ! -z $PRIVATE_KEY ]]; then
    echo "Creating account from private key"
    echo "$PRIVATE_KEY" > ./private_key
    tomo  account import ./private_key \
      --datadir $DATA_DIR \
      --keystore $KEYSTORE_DIR
      --password ./password \
  else
    echo "Creating new account"
    tomo account new \
      --datadir $DATA_DIR \
      --keystore $KEYSTORE_DIR
      --password ./password
  fi
  account=$(
    tomo account list --datadir $DATA_DIR  --keystore $KEYSTORE_DIR \
    2> /dev/null \
    | head -n 1 \
    | cut -d"{" -f 2 | cut -d"}" -f 1
  )
  echo "Using account $account"
  params="$params --unlock $account"
fi

# bootnodes
if [[ ! -z $BOOTNODES ]]; then
  params="$params --bootnodes $BOOTNODES"
fi

# netstats
if [[ ! -z $WS_SECRET ]]; then
  echo "Will report to netstats server ${NETSTATS_HOST}:${NETSTATS_PORT}"
  params="$params --ethstats ${IDENTITY}:${WS_SECRET}@${NETSTATS_HOST}:${NETSTATS_PORT}"
else
  echo "WS_SECRET not set, will not report to netstats server."
fi

exec tomo $params \
  --verbosity 4 \
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
