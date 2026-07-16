#!/bin/bash

# Update packages and install PostgreSQL
apt-get update -y
apt-get install -y postgresql postgresql-contrib

# Create a postgres user and database
# Note: ${db_password} is injected dynamically by Terraform!
sudo -u postgres psql -c "ALTER USER postgres PASSWORD '${db_password}';"
sudo -u postgres psql -c "CREATE DATABASE mydb;"

cat << 'SQL' > /tmp/init.sql
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
SQL

# Execute the SQL file
sudo -u postgres psql -d mydb -f /tmp/init.sql

# Configure PostgreSQL to listen on all interfaces
echo "listen_addresses = '*'" >> /etc/postgresql/16/main/postgresql.conf
echo "host all all 0.0.0.0/0 md5" >> /etc/postgresql/16/main/pg_hba.conf

# Restart PostgreSQL to apply changes
systemctl restart postgresql