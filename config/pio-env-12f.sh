#!/usr/bin/env bash

# 12-factor config, using environment variables for dynamic values

# PredictionIO Main Configuration
#
# This section controls core behavior of PredictionIO. It is very likely that
# you need to change these to fit your site.

# SPARK_HOME: Apache Spark is a hard dependency and must be configured.
# Must match $spark_dist_dir in bin.compile
SPARK_HOME=/app/pio-engine/PredictionIO-dist/vendors/spark-hadoop

POSTGRES_JDBC_DRIVER=/app/lib/postgresql_jdbc.jar

# ES_CONF_DIR: You must configure this if you have advanced configuration for
#              your Elasticsearch setup.
# ES_CONF_DIR=/opt/elasticsearch

# HADOOP_CONF_DIR: You must configure this if you intend to run PredictionIO
#                  with Hadoop 2.
# HADOOP_CONF_DIR=/opt/hadoop

# HBASE_CONF_DIR: You must configure this if you intend to run PredictionIO
#                 with HBase on a remote cluster.
# HBASE_CONF_DIR=$PIO_HOME/vendors/hbase-1.0.0/conf

# Filesystem paths where PredictionIO uses as block storage.
PIO_FS_BASEDIR=$HOME/.pio_store
PIO_FS_ENGINESDIR=$PIO_FS_BASEDIR/engines
PIO_FS_TMPDIR=$PIO_FS_BASEDIR/tmp

# PredictionIO Storage Configuration
#
# This section controls programs that make use of PredictionIO's built-in
# storage facilities. Default values are shown below.
#
# For more information on storage configuration please refer to
# https://docs.prediction.io/system/anotherdatastore/

# Storage Repositories

# Default is to use PostgreSQL
PIO_STORAGE_REPOSITORIES_METADATA_NAME="${PIO_STORAGE_REPOSITORIES_METADATA_NAME-pio_meta}"
PIO_STORAGE_REPOSITORIES_METADATA_SOURCE="${PIO_STORAGE_REPOSITORIES_METADATA_SOURCE-ELASTICSEARCH}"

PIO_STORAGE_REPOSITORIES_EVENTDATA_NAME="${PIO_STORAGE_REPOSITORIES_EVENTDATA_NAME-pio_event}"
PIO_STORAGE_REPOSITORIES_EVENTDATA_SOURCE="${PIO_STORAGE_REPOSITORIES_EVENTDATA_SOURCE-PGSQL}"

PIO_STORAGE_REPOSITORIES_MODELDATA_NAME="${PIO_STORAGE_REPOSITORIES_MODELDATA_NAME-pio_model}"
PIO_STORAGE_REPOSITORIES_MODELDATA_SOURCE="${PIO_STORAGE_REPOSITORIES_MODELDATA_SOURCE-PGSQL}"

# Storage Data Sources

# PostgreSQL Default Settings
PIO_STORAGE_SOURCES_PGSQL_TYPE="${PIO_STORAGE_SOURCES_PGSQL_TYPE-jdbc}"
PIO_STORAGE_SOURCES_PGSQL_URL="${PIO_STORAGE_SOURCES_PGSQL_URL-jdbc:postgresql://localhost/pio}"
PIO_STORAGE_SOURCES_PGSQL_USERNAME="${PIO_STORAGE_SOURCES_PGSQL_USERNAME-pio}"
PIO_STORAGE_SOURCES_PGSQL_PASSWORD="${PIO_STORAGE_SOURCES_PGSQL_PASSWORD-pio}"

# Elasticsearch Settings
PIO_STORAGE_SOURCES_ELASTICSEARCH_TYPE="${PIO_STORAGE_SOURCES_ELASTICSEARCH_TYPE-elasticsearch}"
# PIO_STORAGE_SOURCES_ELASTICSEARCH_CLUSTERNAME=clustername
PIO_STORAGE_SOURCES_ELASTICSEARCH_HOSTS=localhost
PIO_STORAGE_SOURCES_ELASTICSEARCH_PORTS=9300
PIO_STORAGE_SOURCES_ELASTICSEARCH_HOME="/app/pio-engine/PredictionIO-dist/vendors/elasticsearch"
