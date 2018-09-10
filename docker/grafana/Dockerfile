FROM grafana/grafana:5.2.1

LABEL maintainer="etienne@tomochain.com"

COPY ./provisioning /etc/grafana/provisioning
COPY ./dashboards /var/lib/grafana/dashboards
COPY ./entrypoint.sh ./

RUN grafana-cli plugins install raintank-worldping-app

ENTRYPOINT ["./entrypoint.sh"]
