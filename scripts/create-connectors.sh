#!/bin/bash

set -e

echo "Creating Debezium Postgres connector..."

curl -X POST http://localhost:8083/connectors \
  -H "Content-Type: application/json" \
  -d @../connectors/postgres-debezium.json || true

curl -X POST http://localhost:8083/connectors \
  -H "Content-Type: application/json" \
  -d @../connectors/iceberg.json || true

echo "Done."