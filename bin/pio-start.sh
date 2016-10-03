#!/usr/bin/env bash
# Start elasticsearch in default setting for metadata storage source

# Figure out where PredictionIO is installed
BP_DIR=$(cd $(dirname ${0:-}); cd ..; pwd)
dist_dir=$BP_DIR/PredictionIO-dist

# Elasticsearch
echo "Starting Elasticsearch..."
if [ -n "$PIO_STORAGE_SOURCES_ELASTICSEARCH_HOME" ]; then
  if [ -n "$JAVA_HOME" ]; then
    JPS=`$JAVA_HOME/bin/jps`
  else
    JPS=`jps`
  fi
  if [[ ${JPS} =~ "Elasticsearch" ]]; then
    echo -e "\033[0;31mElasticsearch is already running. Please use pio-stop-all to try stopping it first.\033[0m"
    echo -e "\033[0;31mNote: If you started Elasticsearch manually, you will need to kill it manually.\033[0m"
    echo -e "\033[0;31mAborting...\033[0m"
    exit 1
  else
    $PIO_STORAGE_SOURCES_ELASTICSEARCH_HOME/bin/elasticsearch -d -p ${dist_dir}/es.pid
  fi
else
  echo -e "\033[0;31mPlease set PIO_STORAGE_SOURCES_ELASTICSEARCH_HOME in conf/pio-env.sh, or in your environment.\033[0m"
  echo -e "\033[0;31mCannot start Elasticsearch. Aborting...\033[0m"
  exit 1
fi

#PGSQL
pgsqlStatus="$(ps auxwww | grep postgres | wc -l)"
if [[ "$pgsqlStatus" < 5 ]]; then
  # Detect OS
  OS=`uname`
  if [[ "$OS" = "Darwin" ]]; then
    pg_cmd=`which pg_ctl`
    if [[ "$pg_cmd" != "" ]]; then
      pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start
    fi
  elif [[ "$OS" = "Linux" ]]; then
    sudo service postgresql start
  else
    echo -e "\033[1;31mYour OS $OS is not yet supported for automatic postgresql startup:(\033[0m"
    echo -e "\033[1;31mPlease do a manual startup!\033[0m"
    ${dist_dir}/bin/pio-stop-all
    exit 1
  fi
fi

# PredictionIO Event Server
echo "Waiting 10 seconds for HBase to fully initialize..."
sleep 10
echo "Starting PredictionIO Event Server..."
${dist_dir}/bin/pio-daemon ${dist_dir}/eventserver.pid eventserver --ip 0.0.0.0
