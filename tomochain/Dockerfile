FROM etiennenapoleone/tomochain:latest

LABEL maintainer="etienne@tomochain.com"

ENV INDEX '1'
ENV IDENTITY 'unnamed_node'
ENV IS_BOOTNODE 'false'

WORKDIR /node

COPY . ./

ENTRYPOINT ["./entrypoint.sh"]
