FROM tomochain/tomoscan-server:latest

LABEL maintainer="etienne@tomochain.com"

WORKDIR /app

COPY . ./

ENTRYPOINT ["pm2-docker", "start", "pm2.json", "--only", "dev"]
