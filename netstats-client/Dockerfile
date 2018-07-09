FROM tomochain/eth-net-intelligence-api:latest

LABEL maintainer="etienne@tomochain.com"

ENV NODE_ENV 'production'
ENV VERBOSITY '2'
ENV RPC_PORT '8545'
ENV LISTENING_PORT '30303'
ENV WS_SERVER 'ws://netstats-server:3000'
ENV INSTANCE_NAME 'unnamed node'
ENV WS_SECRET ''
ENV RPC_HOST ''
ENV CONTACT_DETAILS ''

COPY . .

ENTRYPOINT ["./entrypoint.sh"]
