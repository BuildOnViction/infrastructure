! This is still in work and is not intended to be operational for now

# Devnet
This is the Devnet branch of the Tomochain infrastructure.

Here resides the configuration used in Tomochain's development network "Devnet".

## Deploy
To deploy the Devnet, you need to be on a swarm enabled machine.

Docker engine now comes with swarm built-in, you just need to enable it.

```
docker swarm init
```

Clone this repo and switch to Devnet branch.

```
git clone https://github.com/tomochain/infrastructure.git
cd infrastructure
git checkout devnet
```

Start the swarm stack.

```
docker stack deploy -c deploy/docker-compose.yml devnet
```
