#!/bin/bash

docker stack rm devnet
docker container prune
docker volume prune
