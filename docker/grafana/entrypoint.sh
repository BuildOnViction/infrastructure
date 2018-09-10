#!/bin/sh

# sleep to wait for postgres init
echo "Waiting 30s for postgres"
sleep 30

exec ./run.sh
