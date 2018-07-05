#!/bin/sh

# sleep to wait for postgres init
echo "Waiting 20s for postgres"
sleep 20

exec ./run.sh
