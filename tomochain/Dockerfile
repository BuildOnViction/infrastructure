FROM tomochain/tomochain:latest

LABEL maintainer="etienne@tomochain.com"

ENV IDENTITY 'unnamed_node'
ENV IS_BOOTNODE 'false'
ENV PASSWORD ''
ENV PRIVATE_KEY ''

WORKDIR /tomochain

COPY . ./

ENTRYPOINT ["./entrypoint.sh"]
