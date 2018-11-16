# 🏗️ Mainnet

This is the mainnet network of the Tomochain infrastructure.

## Requirements

- [Docker](https://docs.docker.com/install/) >= 17.09.0

## Swarms

### Main

Nodes:
_TODO_

Ports exposed:
_TODO_

### Monitoring

Nodes:
_TODO_

Ports exposed:
_TODO_

## Deploy

For each swarm:

Clone the repository on the manager node and checkout the develop branch.

```bash
git clone https://github.com/tomochain/infrastructure.git
cd infrastructure/networks/mainnet/[swarm name]
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
docker stack deploy -c 00... mainnet-[swarm name]
docker stack deploy -c 01... mainnet-[swarm name]
...
```

## Access

- RPC endpoint: `https://rpc.tomochain.com`
- WS endpoint: `https://ws.tomochain.com`
- [Netstats](https://stats.tomochain.com)
- [TomoMaster](https://master.tomochain.com)
- [TomoScan](https://scan.tomochain.com)
- [Grafana](https://grafana.tomochain.com)
- [Graylog](https://graylog.tomochain.com)

## Undeploy

In case you want to reset a swarm, just run that on the manager:

```bash
docker stack rm mainnet
```

You might need to prune volumes on host.
