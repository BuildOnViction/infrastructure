from node:8-alpine as git

WORKDIR /ethnetstats

RUN apk update && \
    apk upgrade && \
    apk add git && \
    git clone https://github.com/tomochain/eth-netstats .

FROM node:8-alpine

LABEL maintainer="etienne@tomochain.com"

ENV WS_SECRET ''

WORKDIR /ethnetstats

COPY --from=git /ethnetstats .

RUN npm install && \
    npm install -g grunt-cli && \
    grunt

ENTRYPOINT ["npm", "start"]
