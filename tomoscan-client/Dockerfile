FROM tomochain/tomoscan-client:latest

LABEL maintainer="etienne@tomochain.com"

WORKDIR /app

COPY . ./

EXPOSE 3000

RUN npm run build
