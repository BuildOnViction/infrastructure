FROM tomochain/tomochain:latest

LABEL maintainer="etienne@tomochain.com"

ENV IDENTITY 'unnamed_node'
ENV PASSWORD ''
ENV PRIVATE_KEY ''
ENV BOOTNODES ''
ENV WS_SECRET ''
ENV NETSTATS_HOST 'netstats-server'
ENV NETSTATS_PORT '3000'

WORKDIR /tomochain

COPY . ./

ENTRYPOINT ["./entrypoint.sh"]
