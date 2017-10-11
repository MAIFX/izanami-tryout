#!/usr/bin/env bash
export AKKA_CLUSTER_HOST=$(awk 'END{print $1}' /etc/hosts)
export AKKA_CLUSTER_BIND_HOST=$(awk 'END{print $1}' /etc/hosts)

./bin/opun-izanami -Dlogger.file=./conf/prod-logger.xml "$@"
