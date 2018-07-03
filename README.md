# infrastructure: localnet

🏗️ Work in progress 🚧

This is the localnet branch of the Tomochain infrastructure.

This repo holds the dockerized infrastructure meant to be used to test local development.

## Requirements

- Docker

## Initialize

Before deploying, you need to fill in some passwords and private values who can't be versioned.
You can run the `init.sh` multiple times, just keep in minds it will overwrite all the file on each runs.

```
git clone https://github.com/tomochain/infrastructure.git
cd infrastructure
git checkout localnet

./init.sh
```

Also, if you don't need the whole infrastructure, feel free to edit `deploy.sh`, `redeploy.sh`, `undeploy.sh` and `logs.sh` to remove the unwanted docker-compose files.

## Deploy

To build the images, create the containers and start them, simply run `deploy.sh`.

```
./deploy.sh

./logs.sh       # if you want to follow the logs
```

## Access

- Netstats: http://localhost:3000
- Tomomaster: http://localhost:3001
- Tomoscan: http://localhost:3002
- Grafana: http://localhost:3003

## Workflow

This is subject to change. The goal is to reduce manual steps.

Exemple when working on the tomochain repo.

Let's say you have the infrastructure and and tomochain repo cloned locally on your machine.
```
repos
├── infrastructure
├── tomochain
└── ...
```

- Edit some code in the tomochain repo
- Build the base from tomochain repo `docker build -t tomochain/tomochain:latest .`
- In the infrastructure repo, run `./redeploy.sh`

And voilà!

## Undeploy

In case you want to reset your environment, run `undeploy.sh`
```
./undeploy
```
It will prompt you for volumes pruning. It's handy for deleting all the persistent volumes created for localnet but be aware that it can also delete unrelated volumes
