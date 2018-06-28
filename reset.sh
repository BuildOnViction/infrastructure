#!/bin/bash
set -x
docker stack rm devnet
docker volume rm keystore
docker volume rm genesis
