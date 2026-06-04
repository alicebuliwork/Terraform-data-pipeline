FROM confluentinc/cp-kafka-connect:6.2.13

USER root

RUN yum install -y wget tar gzip

ENV CONNECT_PLUGIN_PATH="/usr/share/java,/usr/share/confluent-hub-components"

RUN mkdir -p /usr/share/confluent-hub-components

# Download official Debezium Postgres connector archive
RUN wget https://repo1.maven.org/maven2/io/debezium/debezium-connector-postgres/2.6.0.Final/debezium-connector-postgres-2.6.0.Final-plugin.tar.gz \
    -O /tmp/debezium.tar.gz

# Extract it
RUN tar -xvzf /tmp/debezium.tar.gz -C /usr/share/confluent-hub-components/

# cleanup
RUN rm -f /tmp/debezium.tar.gz

RUN mkdir -p /usr/share/confluent-hub-components/iceberg-sink/lib
RUN confluent-hub install --no-prompt iceberg/iceberg-kafka-connect:1.9.2

USER appuser