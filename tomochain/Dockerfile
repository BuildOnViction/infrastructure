FROM golang:1.9.4-stretch

LABEL maintainer="etienne@tomochain.com"

# TODO: add healthcheck

WORKDIR /build

ENV WALLET_KEY ""
ENV WS_SECRET changeme
ENV INSTANCE_NAME changeme
ENV CONTACT_DETAILS ""

COPY ./genesis.json /build/genesis.json
COPY ./template.json /build/template.json
COPY ./entrypoint.sh /build/entrypoint.sh
COPY ./healthcheck.sh /build/healthcheck.sh
COPY ./.bootnodes /build/.bootnodes

RUN chmod +x /build/entrypoint.sh && \
    chmod +x /build/healthcheck.sh && \
    echo $WALLET_KEY > /build/.pwd

RUN apt-get update && apt-get install -y git build-essential && \
    git clone https://github.com/tomochain/tomochain.git tomochain && \
    (cd tomochain && git checkout --detach ee4379f00776447c0ddbf95edd3135d9ee6a4d6b &&  make tomo)

RUN cp tomochain/build/bin/tomo /usr/local/bin && chmod +x /usr/local/bin/tomo && \
    rm -rf tomochain

EXPOSE 8545
EXPOSE 30303

ENTRYPOINT ["/build/entrypoint.sh"]
