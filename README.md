# infrastructure: devnet

🏗️ Work in progress 🚧

This is the devnet branch of the Tomochain infrastructure.

This repo holds the devnet dockerized infrastructure.

## Requirements

- [Docker](https://docs.docker.com/install/) >= 17.09.0
- [Docker-compose](https://docs.docker.com/compose/install/)

## Initialize

Firstly, clone the repository and checkout the devnet branch.

```
git clone https://github.com/tomochain/infrastructure.git
cd infrastructure
git checkout devnet
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

- [Netstats](https://stats.devnet.tomochain.com)
- [Tomomaster](https://master.devnet.tomochain.com)
- [Tomoscan](https://scan.devnet.tomochain.com)
- [Grafana](https://grafana.devnet.tomochain.com)

## Undeploy

In case you want to reset the environment.

```
./undeploy
```

It will prompt you for volumes pruning. It's handy for deleting all the persistent volumes created for devnet but be aware that it can also delete unrelated volumes
