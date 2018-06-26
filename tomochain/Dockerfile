FROM tomochain/tomochain:latest

LABEL maintainer="etienne@tomochain.com"

ENV INDEX '1'
ENV IDENTITY 'unnamed_node'
ENV IS_BOOTNODE 'false'

WORKDIR /tomochain

COPY . ./

ENTRYPOINT ["./entrypoint.sh"]
