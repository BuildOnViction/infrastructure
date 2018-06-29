#!/bin/bash
set -x
docker stack rm localnet
docker volume rm keystore
docker volume rm genesis
