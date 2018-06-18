#!/bin/bash

blockNumber=`geth attach /build/vet/geth.ipc --exec 'eth.blockNumber'`

if [ ! -f /build/.healthcheck ]; then
  echo ${blockNumber} > /build/.healthcheck
  exit 0
fi

prvBlockNumber=`cat /build/.healthcheck`

if [ "${blockNumber}" == "${prvBlockNumber}" ]; then
  pkill -HUP geth
fi
echo ${blockNumber} > /build/.healthcheck
