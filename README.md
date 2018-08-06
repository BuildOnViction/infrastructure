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

Build the images and create the swarm services.

```
./deploy.sh
```

## Access

- [Netstats](http://localhost:3000)
- [Tomomaster](http://localhost:3001)
- [Tomoscan](http://localhost:3002)
- [Grafana](http://localhost:3003)
- RPC http://localhost:8545 (moon)
- Masternode client http://localhost:30303 (moon)

## Update (for Tomochain devs)

When working on one of the Tomochain projects parts of the infrastructure, you can test your latest code by rebuilding your base image with the tag `tomochain/infra-projectname`. And then launch the update script with the service name as parameter.
Ex. with Tomomaster:

```
~/projects/tomomaster$ docker build -t tomochain/infra-tomomaster .
~/projects/tomomaster$ cd ~/projects/infrastructure
~/projects/infrastructure$ ./update.sh tomomaster

```

Launching it without arguments will rebuild all the containers. You will need to wait approx. 5 mins for the update container to update all your services automatically.

## Undeploy

In case you want to reset the environment.

```
./undeploy
```

It will prompt you for volumes pruning. It's handy for deleting all the persistent volumes created for localnet but be aware that it can also delete unrelated volumes
