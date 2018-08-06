#!/bin/bash

docker stack rm localnet
docker container prune
docker volume prune
