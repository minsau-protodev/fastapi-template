#!/usr/bin/env bash

cd /opt/app
if [[ "${RUNTYPE}" == "bash" ]]; then
    printf "started Docker container as runtype \e[1;93mbash\e[0m\n"
    exec /bin/bash

else
    if [[ -z "${NEW_RELIC_LICENSE_KEY}" ]]; then
      printf "started Docker container as runtype \e[1;93mweb\e[0m\n with newrelic"
      exec NEW_RELIC_CONFIG_FILE=newrelic.ini newrelic-admin run-program gunicorn --bind :$PORT --workers 1 --worker-class uvicorn.workers.UvicornWorker  --threads 8 main:app
    else
      printf "started Docker container as runtype \e[1;93mweb\e[0m\n"
      exec gunicorn --bind :$PORT --workers 1 --worker-class uvicorn.workers.UvicornWorker  --threads 8 main:app
    fi
fi
