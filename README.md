# infrastructure: devnet

🏗️ Work in progress 🚧

This is the devnet branch of the Tomochain infrastructure.

This repo holds the dockerized infrastructure meant to be used to test local development.

## Requirements

- Docker
- Docker-compose

## Initialize

Firstly, clone the repository and checkout the devnet branch.

```
git clone https://github.com/tomochain/infrastructure.git
cd infrastructure
git checkout devnet
```

Before deploying, we need to configure our environment.
Edit the `COMPOSE_FILE` variable of the `.env` if you want to deploy only certain parts of the infrastructure.
Run `./init.sh` to create the configuration folder.

```
vim .env       # optional
./init.sh
```

⚠️ This command will reset the **whole** configuration folder on every run.

Now edit the `# please fill` parts of the configuration (`deploy/config`)

## Deploy

To build the images, create the containers and start them, simply run `deploy.sh`.

```
./deploy.sh

./logs.sh       # if you want to follow the logs
```

You can also control individual parts of the infrastructure.

```
docker-compose -f deploy/tomochain.yml down|up|logs
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
- Build the base image from tomochain repo `docker build -t tomochain/tomochain:latest .`
- In the infrastructure repo, run `./redeploy.sh`

And voilà!

## Undeploy

In case you want to reset your environment, run `undeploy.sh`

```
./undeploy
```

It will prompt you for volumes pruning. It's handy for deleting all the persistent volumes created for devnet but be aware that it can also delete unrelated volumes
