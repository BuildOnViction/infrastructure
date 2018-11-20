FROM graylog/graylog:2.4

LABEL maintainer="etienne@tomochain.com"

ENV GRAYLOG_ROOT_TIMEZONE Asia/Ho_Chi_Minh

COPY ./entrypoint.sh slack-3.1.0.jar ./

ENTRYPOINT ["./entrypoint.sh"]

CMD ["graylog"]
