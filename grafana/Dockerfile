FROM grafana/grafana:5.1.3

LABEL maintainer="etienne@tomochain.com"

COPY ./provisioning /etc/grafana/provisioning
COPY ./dashboards /var/lib/grafana/dashboards
COPY ./entrypoint.sh ./

ENTRYPOINT ["./entrypoint.sh"]
