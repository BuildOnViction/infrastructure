# infrastructure: localnet

🏗️ Work in progress 🚧

This is the localnet branch of the Tomochain infrastructure.

This repo holds the localnet dockerized infrastructure.

## Requirements

- [Docker](https://docs.docker.com/install/) >= 17.09.0
- [Docker-compose](https://docs.docker.com/compose/install/)

## Initialize

Firstly, clone the repository and checkout the localnet branch.

```
git clone https://github.com/tomochain/infrastructure.git
cd infrastructure
git checkout localnet
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

Create de swarm services.

```
./deploy.sh
```

## Access

- [Netstats](https://stats.localnet.tomochain.com)
- [Tomomaster](https://master.localnet.tomochain.com)
- [Tomoscan](https://scan.localnet.tomochain.com)
- [Grafana](https://grafana.localnet.tomochain.com)

## Undeploy

In case you want to reset the environment.

```
./undeploy
```

It will prompt you for volumes pruning. It's handy for deleting all the persistent volumes created for localnet but be aware that it can also delete unrelated volumes
