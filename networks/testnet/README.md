# testnet

This is the testnet network of the Tomochain infrastructure.

## Requirements

- [Docker](https://docs.docker.com/install/) >= 17.09.0
- [Docker-compose](https://docs.docker.com/compose/install/)

## Initialize

Firstly, clone the repository on the hosts and checkout the testnet branch.

```
git clone https://github.com/tomochain/infrastructure.git
cd infrastructure/networks/testnet/$HOST
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
docker stack deploy -c 01... testnet
docker stack deploy -c 02... testnet
...
```

## Access

- [Netstats](https://stats.testnet.tomochain.com)
- [TomoMaster](https://master.testnet.tomochain.com)
- [TomoScan](https://scan.testnet.tomochain.com)
- [Grafana](https://grafana.testnet.tomochain.com)

## Undeploy

In case you want to reset the environment:

```
docker stack rm testnet
docker container prune
docker volume prune
```
