FROM traefik:1.15-alpine

LABEL maintainer="etienne@tomochain.com"

COPY nginx.conf /etc/nginx/nginx.conf:ro

ENTRYPOINT ["/entrypoint.sh"]

CMD ["nginx", "-g", "daemon off;"]
