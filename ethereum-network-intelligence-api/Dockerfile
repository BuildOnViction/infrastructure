from node:8-alpine as git

WORKDIR /eniapi

RUN apk update && \
    apk upgrade && \
    apk add git && \
    git clone https://github.com/cubedro/eth-net-intelligence-api .

FROM node:8-alpine

LABEL maintainer="etienne@tomochain.com"
# TODO change json to env

WORKDIR /eniapi

ENV WS_SECRET ''
ENV CONTACT_DETAILS ''
ENV INSTANCE_NAME 'unnamed node'

RUN npm install -g pm2

COPY --from=git /eniapi /eniapi
COPY ./app.json ./app.json

ENTRYPOINT ["pm2", "start", "--no-daemon", "app.json"]
