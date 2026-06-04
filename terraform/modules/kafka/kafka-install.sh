#!/bin/bash

set -e

yum update -y

# Java (required for Confluent)
yum install -y java-17-amazon-corretto

# Confluent repo
rpm --import https://packages.confluent.io/rpm/7.7/archive.key

cat >/etc/yum.repos.d/confluent.repo <<EOF
[Confluent]
name=Confluent repository
baseurl=https://packages.confluent.io/rpm/7.7
gpgcheck=1
enabled=1
EOF

# Install full Confluent Platform (Community)
yum install -y confluent-platform

# Enable services
systemctl enable confluent-zookeeper
systemctl enable confluent-kafka
systemctl enable confluent-schema-registry
systemctl enable confluent-kafka-connect
systemctl enable confluent-control-center

systemctl start confluent-zookeeper
systemctl start confluent-kafka
systemctl start confluent-schema-registry
systemctl start confluent-kafka-connect
systemctl start confluent-control-center