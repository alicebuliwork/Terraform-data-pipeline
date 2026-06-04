#!/bin/bash

docker exec -it broker kafka-topics --create \
  --topic cdc.public.orders \
  --bootstrap-server broker:29092 \
  --partitions 3 \
  --replication-factor 1 || true

