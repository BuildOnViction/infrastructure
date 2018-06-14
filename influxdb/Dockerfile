FROM influxdb:1.5.3-alpine

LABEL maintainer="etienne@tomochain.com"

ENV INFLUXDB_DB telegraf

ENTRYPOINT ["/entrypoint.sh"]

CMD ["influxd"]
