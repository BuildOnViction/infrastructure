#!/bin/bash

is_initialized=false
is_first_node=false
wallet=''
bootnodes=$(cat .bootnodes | awk '{print}' ORS=',')

# if the chain exists
if [[ -d tomochain/tomo/chaindata ]]; then
  is_initialized=true
  # retrieve existing base wallet
  wallet=$(tomo account list --datadir /build/tomochain | head -n 1 | awk -v FS='({|})' '{print $2}')
else
  # create a new wallet
  wallet=$(tomo account new --password .pwd --datadir tomochain | awk -v FS='({|})' '{print $2}')
fi

# if the bootnode file is empty
if [[ -z $bootnodes ]]; then
  is_first_node=true
fi

# if this is the first or a standalone node
if [[ "$is_first_node" = true ]]; then
  echo "No bootnodes found, assuming this is a first or standalone node."
  if [[ "$is_initialized" = false ]]; then
    echo "No chain data found. Initializing genesis block"
    sed "s/:wallet:/$wallet/g" template.json > genesis.json
    tomo --datadir tomochain init genesis.json
  fi
  echo "Starting..."
  tomo --datadir /build/tomochain \
       --networkid 89 \
       --rpc \
       --rpccorsdomain "*" \
       --rpcaddr 0.0.0.0 \
       --rpcport 8545 \
       --rpcvhosts "*" \
       --unlock ${wallet} \
       --password .pwd \
       --mine \
       --gasprice "1" \
       --targetgaslimit "420000000"
else
  echo "Bootnodes found, starting this node as part of an existing blockchain"
  if [[ "$is_initialized" = false ]]; then
    echo "No chain data found. Initializing genesis block."
    tomo --datadir tomochain init genesis.json
  fi
  echo "Starting..."
  tomo --bootnodes ${bootnodes} \
       --datadir /build/tomochain \
       --networkid 89 \
       --rpc \
       --rpccorsdomain "*" \
       --rpcaddr 0.0.0.0 \
       --rpcport 8545 \
       --rpcvhosts "*" \
       --unlock ${wallet} \
       --password .pwd \
       --mine \
       --gasprice "1" \
       --targetgaslimit "420000000"
fi
