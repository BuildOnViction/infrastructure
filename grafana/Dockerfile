FROM grafana/grafana:5.1.3

LABEL maintainer="etienne@tomochain.com"

ENV GF_PATH_PROVISIONING=/etc/grafana/provisioning \
    GF_AUTH_ANONYMOUS_ENABLED=true \
    GF_SECURITY_ADMIN_PASSWORD=tomochain

COPY ./provisioning /etc/grafana/provisioning
COPY ./dashboards /var/lib/grafana/dashboards
