FROM traefik:alpine

LABEL maintainer="etienne@tomochain.com"

COPY traefik.toml /etc/traefik/traefik.toml

ENTRYPOINT ["/entrypoint.sh"]

CMD ["traefik"]
