! This is still in work and is not intended to be operational for now

# Localnet
This is the Localnet branch of the Tomochain infrastructure.

Here resides the configuration used in Tomochain's development network "Localnet".

## Deploy
To deploy the Localnet, you need to be on a swarm enabled machine.

Docker engine now comes with swarm built-in, you just need to enable it.

```
docker swarm init
```

Clone this repo and switch to Localnet branch.

```
git clone https://github.com/tomochain/infrastructure.git
cd infrastructure
git checkout localnet
```

Create the password for the masternodes wallets.

```
echo "$PASSWORD" > password
```

To deploy, init and start the swarm stack.

```
./init # only before first run
docker stack deploy -c deploy/docker-compose.yml localnet
```

To restart from zero:

```
docker stack rm localnet 
./reset.sh
docker container prune
docker volume prune
```
