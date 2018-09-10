# devnet

This is the devnet network of the Tomochain infrastructure.

## Requirements

- [Docker](https://docs.docker.com/install/) >= 17.09.0
- [Docker-compose](https://docs.docker.com/compose/install/)

## Initialize

Firstly, clone the repository on the hosts and checkout the devnet branch.

```
git clone https://github.com/tomochain/infrastructure.git
cd infrastructure/networks/devnet/$HOST
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

Create de swarm services by deploying each stack files.

```
docker stack deploy -c 01... devnet
docker stack deploy -c 02... devnet
...
```

## Access

- [Netstats](https://stats.devnet.tomochain.com)
- [TomoMaster](https://master.devnet.tomochain.com)
- [TomoScan](https://scan.devnet.tomochain.com)
- [Grafana](https://grafana.devnet.tomochain.com)

## Undeploy

In case you want to reset the environment:

```
docker stack rm devnet
docker container prune
docker volume prune
```
