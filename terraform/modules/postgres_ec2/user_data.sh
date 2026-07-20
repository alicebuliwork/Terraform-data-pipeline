#!/bin/bash

# 1. Update packages and install PostgreSQL 15 (Standard on Amazon Linux 2023)
dnf update -y
dnf install -y postgresql15-server postgresql15

# 2. Initialize the database storage cluster (Mandatory on Red Hat/Amazon Linux)
postgresql-setup --initdb

# 3. Locate the dynamic data directory path 
# On Amazon Linux, configurations live right next to the data in /var/lib/pgsql/data/
DATA_DIR="/var/lib/pgsql/data"

# 4. Inject Change Data Capture (CDC) / Debezium parameters
echo "wal_level = logical" | sudo tee -a $DATA_DIR/postgresql.conf
echo "max_wal_senders = 10" | sudo tee -a $DATA_DIR/postgresql.conf
echo "max_replication_slots = 10" | sudo tee -a $DATA_DIR/postgresql.conf

# 5. Configure PostgreSQL to listen on all network interfaces 
echo "listen_addresses = '*'" | sudo tee -a $DATA_DIR/postgresql.conf
echo "host all all 0.0.0.0/0 md5" | sudo tee -a $DATA_DIR/pg_hba.conf

# 6. Start and Enable PostgreSQL service 
systemctl daemon-reload
systemctl enable postgresql --now

# 7. Set the postgres master password (Dynamically injected by Terraform variable)
sudo -u postgres psql -c "ALTER USER postgres PASSWORD '${db_password}';"

# 8. Create your custom target database
sudo -u postgres psql -c "CREATE DATABASE mydb;"

# 9. Execute the SQL schema straight into the new 'mydb' database
# Ensure /tmp/init.sql exists or has been copied over via a file provisioner first
cat << 'EOF' > /tmp/init.sql
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_name VARCHAR(255),
    amount INT,
    status VARCHAR(50),
    created_at TIMESTAMP DEFAULT NOW()
);

INSERT INTO orders (customer_name, amount, status)
VALUES
('Alice', 120, 'NEW'),
('Bob', 75, 'PAID'),
('Charlie', 200, 'SHIPPED');
EOF

# Change ownership so the postgres user is allowed to read it
chown postgres:postgres /tmp/init.sql

# 8. Execute the initialization file script straight into mydb
sudo -u postgres psql -d mydb -f /tmp/init.sql

# 10. Restart PostgreSQL to finalize the wal_level and network configurations
systemctl restart postgresql