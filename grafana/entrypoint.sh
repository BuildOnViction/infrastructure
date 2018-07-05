#!/bin/sh

# sleep to wait for postgres init
echo "Waiting 10s for postgres"
sleep 10

exec ./run.sh
