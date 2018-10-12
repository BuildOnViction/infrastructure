# logging

This is non-prod logging infrastructure.

## Requirements

- [Docker](https://docs.docker.com/install/) >= 17.09.0
- [Docker-compose](https://docs.docker.com/compose/install/)

## Initialize

Firstly, clone the repository on the hosts and checkout the logging branch.

```
git clone https://github.com/tomochain/infrastructure.git
cd infrastructure/networks/main/logging
```

The host should be in swarm mode.

```
docker swarm init
```

We need to set some sensitive data as docker secrets.

```
./init.sh
```

## Deploy

Create the swarm services by deploying each stack files.

```
docker stack deploy -c 01... logging
docker stack deploy -c 02... logging
...
```

## Undeploy

In case you want to reset the environment:

```
docker stack rm logging
docker container prune
docker volume prune
```
