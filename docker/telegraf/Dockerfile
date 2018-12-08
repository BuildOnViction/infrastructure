FROM telegraf:1.7

LABEL maintainer="etienne@tomochain.com"

ENV METRICS_ENDPOINT='' \
    HOST_SYS=/rootfs/sys \
    HOST_PROC=/rootfs/proc \
    HOST_ETC=/rootfs/etc

WORKDIR /etc/telegraf/

COPY ./telegraf.conf ./telegraf.conf

ENTRYPOINT ["/entrypoint.sh"]

CMD ["telegraf"]
