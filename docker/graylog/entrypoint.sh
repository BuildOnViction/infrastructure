#!/usr/bin/env bash
source /etc/profile

if [[ ! -z $GRAYLOG_PASSWORD_SECRET_FILE ]]; then
  export GRAYLOG_PASSWORD_SECRET=$(cat $GRAYLOG_PASSWORD_SECRET_FILE)
fi

if [[ ! -z $GRAYLOG_ROOT_PASSWORD_SHA2_FILE ]]; then
  export GRAYLOG_ROOT_PASSWORD_SHA2=$(cat $GRAYLOG_ROOT_PASSWORD_SHA2_FILE)
fi

set -e

if [ "${1:0:1}" = '-' ]; then
  set -- graylog "$@"
fi

# Delete outdated PID file
[[ -e /tmp/graylog.pid ]] && rm --force /tmp/graylog.pid

# Create data directories
if [[ "$1" = 'graylog' ]] && [[ "$(id -u)" = '0' ]]; then
  for d in journal log plugin config contentpacks; do
    dir=${GRAYLOG_HOME}/data/$d
    [[ -d "${dir}" ]] || mkdir -p "${dir}"
  done

  chown --recursive "${GRAYLOG_USER}":"${GRAYLOG_GROUP}" "${GRAYLOG_HOME}/data"

  # Start Graylog server
  # shellcheck disable=SC2086
  set -- gosu ${GRAYLOG_USER} "${JAVA_HOME}/bin/java" ${GRAYLOG_SERVER_JAVA_OPTS} \
      -jar \
      -Dlog4j.configurationFile=${GRAYLOG_HOME}/data/config/log4j2.xml \
      -Djava.library.path=${GRAYLOG_HOME}/lib/sigar/ \
      -Dgraylog2.installation_source=docker \
      ${GRAYLOG_HOME}/graylog.jar \
      server \
      -f ${GRAYLOG_HOME}/data/config/graylog.conf ${GRAYLOG_SERVER_OPTS}
fi

# Allow the user to run arbitrarily commands like bash
exec "$@"
