FROM etienne-napoleone/tomochain:latest

LABEL maintainer="etienne@tomochain.com"

ENV PASSWORD ''

WORKDIR /node

COPY . ./

RUN echo "$PASSWORD" > password

ENTRYPOINT ["./entrypoint.sh"]
