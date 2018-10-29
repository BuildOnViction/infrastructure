FROM graylog/graylog:2.4

LABEL maintainer="etienne@tomochain.com"

ENV GRAYLOG_ROOT_TIMEZONE Asia/Ho_Chi_Minh

COPY ./entrypoint.sh ./

ENTRYPOINT ["./entrypoint.sh"]

CMD ["graylog"]
