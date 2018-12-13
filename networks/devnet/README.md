# 🏗️ Devnet

This is the devnet network of the Tomochain infrastructure.

## Requirements

- [Docker](https://docs.docker.com/install/) >= 17.09.0

## Swarms

### Main

Nodes:
- manager (drain mode)
- sun
- moon
- earth
- apps

### Monitoring

Nodes:
- manager (drain mode)
- apps

## Deploy

For each swarm:

Clone the repository on the manager node and checkout the develop branch.

```bash
git clone https://github.com/tomochain/infrastructure.git
cd infrastructure/networks/devnet/[swarm name]
```

Enable swarm mode.

```bash
docker swarm init
```

Disable scheduling containers on the swarm master.

```bash
docker node update --availability drain [manager node name]
```

Give the appropriate tags to the nodes.

```bash
docker node update --label-add <key>=<value> <node-id>
```

Connect the other worker nodes and setup their names and roles.

Set the docker secrets.

```bash
./init.sh
```

Create the swarm services by deploying each stack files.

```bash
docker stack deploy -c 00... devnet
docker stack deploy -c 01... devnet
...
```

## Access

- [Netstats](https://stats.devnet.tomochain.com)
- [TomoMaster](https://master.devnet.tomochain.com)
- [TomoScan](https://scan.devnet.tomochain.com)
- [Grafana](https://grafana.devnet.tomochain.com)
- [Graylog](https://graylog.devnet.tomochain.com)

## Undeploy

In case you want to reset a swarm, just run that on the manager:

```bash
docker stack rm devnet
docker container prune
docker volume prune
```
