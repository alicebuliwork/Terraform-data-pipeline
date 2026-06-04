# Adds needed connector plugins to the connect base image


FROM confluentinc/cp-kafka-connect:6.2.13

USER root

ENV CONNECT_PLUGIN_PATH="/usr/share/java,/usr/share/confluent-hub-components"

RUN mkdir -p /usr/share/confluent-hub-components

# Install Debezium PostgreSQL connector
RUN confluent-hub install --no-prompt debezium/debezium-connector-postgresql:2.5.4
# Install Iceberg Sink connector
RUN confluent-hub install --no-prompt iceberg/iceberg-kafka-connect:1.9.2

USER appuser