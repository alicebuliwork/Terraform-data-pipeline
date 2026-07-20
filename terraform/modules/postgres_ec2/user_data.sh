#!/bin/bash

# 1. Update packages and install PostgreSQL
apt-get update -y
apt-get install -y postgresql postgresql-contrib

# 2. Inject Change Data Capture (CDC) / Debezium parameters
echo "wal_level = logical" >> /etc/postgresql/16/main/postgresql.conf
echo "max_wal_senders = 10" >> /etc/postgresql/16/main/postgresql.conf
echo "max_replication_slots = 10" >> /etc/postgresql/16/main/postgresql.conf

# 3. Configure PostgreSQL to listen on all interfaces 
echo "listen_addresses = '*'" >> /etc/postgresql/16/main/postgresql.conf
echo "host all all 0.0.0.0/0 md5" >> /etc/postgresql/16/main/pg_hba.conf

# 4. Restart PostgreSQL to apply the networking and wal_level changes
systemctl restart postgresql

# 5. Set the postgres master password (Dynamically injected by Terraform variable)
sudo -u postgres psql -c "ALTER USER postgres PASSWORD '${db_password}';"

# 6. Create your custom target database
sudo -u postgres psql -c "CREATE DATABASE mydb;"

# 8. Execute the SQL schema straight into the new 'mydb' database
sudo -u postgres psql -d mydb -f /tmp/init.sql

# Restart PostgreSQL to apply changes
systemctl restart postgresql