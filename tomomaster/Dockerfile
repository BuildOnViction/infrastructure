FROM tomochain/tomomaster:latest

LABEL maintainer="etienne@tomochain.com"

WORKDIR /app

COPY . ./

RUN mv local.json config/ \
    && cp config/local.json config/default.json \
    && rm -rf node_modules \
    && apk --no-cache --virtual deps add \
      python \
      make \
      g++ \
      bash \
      git \
    && npm install -g pm2 truffle \
    && npm install \
    && truffle deploy --reset --network tomo \
    && npm run build \
    && rm -rf node_modules \
    && npm install --production \
    && apk del deps
