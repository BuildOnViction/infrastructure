#!/bin/bash

docker stack deploy -c <(docker-compose config) devnet
