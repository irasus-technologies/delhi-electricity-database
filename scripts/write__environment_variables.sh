#!/bin/bash

DIRECTORY=`pwd`

if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    echo "Usage: /bin/bash ${DIRECTORY}/scripts/$(basename $0) .env.main.template .env.main key0=value0 key1=value1"
    exit 0
fi

INPUT=$1
OUTPUT=$2

shift 2

export "$@"
export $(cat ${DIRECTORY}/.versions/Dockerfile | grep "ARG " | sed -e '/^ARG /!d' -e 's/ARG //g')

envsubst '\${FLYWAY_VERSION} \${POSTGRES_VERSION} \${PYTHON_VERSION} \${TIMESCALEDB_VERSION} \${UBUNTU_VERSION}' < "${INPUT}" > "${OUTPUT}"
