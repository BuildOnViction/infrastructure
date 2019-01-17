FROM graylog/graylog:2.5

LABEL maintainer="etienne@tomochain.com"

ENV GRAYLOG_ROOT_TIMEZONE Asia/Ho_Chi_Minh

COPY ./entrypoint.sh ./
COPY ./slack-3.1.0.jar ./plugin/

ENTRYPOINT ["./entrypoint.sh"]

CMD ["graylog"]
