# Mission DevOps

Hey,

** You can setup all the ec2/db in local environment, the rest has to be on the cloud with terraform.

Thank you for your interest in the DataOps DevOps Engineer position.
As part of our hiring process, we'd like you to complete a home assignment. This will give us a chance to see how you work with real-world data infrastructure challenges.

## Important

Throughout the assignment, please make sure your work is auditable. This includes clear Terraform outputs, meaningful resource naming, comments in configuration files, and any relevant logs or screenshots that allow us to review exactly what was provisioned and configured on each machine.

## Overview

Set up a data pipeline infrastructure on AWS using Terraform, demonstrating your ability to provision, configure, and integrate data systems end-to-end.

The expected flow is:

```text
SQL Database (CDC) → Confluent Platform (Kafka) → S3 Tables (Iceberg)
```

## Tasks

### 1. Terraform Infrastructure

- All resources provisioned via Terraform — no manual AWS console clicks
- Remote state in S3 backend with native S3 locking (`use_lockfile = true`) — no DynamoDB needed
- Use variables, locals, and outputs appropriately
- Organize into modules:
  - networking
  - kafka
  - database
  - s3tables

### 2. Networking

- VPC with subnets of your choice
- Security groups with least-privilege rules
- IAM roles for EC2 instances are preferable — avoid hardcoded credentials

### 3. EC2 — Confluent Platform (Community Edition)

- Launch an EC2 instance
- Install Confluent Platform Community Edition via apt/yum repo
- Configure and start:
  - Kafka Broker
  - Schema Registry
  - Kafka Connect
  - Control Center
- Create a topic: `cdc.orders`
- Use Confluent Control Center to visualize and monitor the pipeline
- Deploy the Iceberg Kafka Connect Sink connector (e.g. `tabular-io/iceberg-kafka-connect`) on the same Kafka Connect instance to write directly from `cdc.orders` to S3 Tables — no additional EC2 or consumer service needed

### 4. EC2 — SQL Database (CDC Source)

- Launch an EC2 instance with PostgreSQL or MySQL (your choice)
- Create a sample orders table with fields:
  - `id`
  - `customer_name`
  - `amount`
  - `status`
  - `created_at`
- Enable CDC at the DB level (`wal_level = logical` for Postgres / `binlog ROW` for MySQL)
- Deploy a Debezium connector via Kafka Connect REST API to stream changes into `cdc.orders`

### 5. S3 Tables (Iceberg) — Required

- Create an S3 Table Bucket via Terraform using the `aws_s3tables_table_bucket` resource
- Create a namespace and an Iceberg table named `orders`
- The table must include the following columns:
  - `id`
  - `customer_name`
  - `amount`
  - `status`
  - `created_at`
  - `__op` (CDC operation type)
  - `__source_ts` (original DB change timestamp)
- Verify data landed correctly by querying the table and include a screenshot

## Deliverables

Please submit a GitHub repository containing:

- All Terraform and configuration code
- A README explaining how to deploy from scratch (`terraform init` → `terraform apply`), how to test the CDC flow end-to-end, and any design decisions you made
- A screenshot of Confluent Control Center showing the pipeline activity
- A screenshot confirming data landed in the S3 Table
- Screenshots or a short screen recording of the pipeline working end-to-end

## Evaluation Criteria

| Area | What We Look For |
|--------|------------------|
| Terraform | Modular, clean, no hardcoded values |
| Confluent setup | Broker, Connect, Control Center all running |
| CDC flow | DB change → Kafka → S3 Table works end-to-end |
| Iceberg connector | Correctly configured, writing to S3 Tables |
| S3 Tables | Correct Iceberg schema, data verified |
| Security | IAM roles, tight security groups, no secrets in code |
| Documentation | Clear README, reproducible from scratch |

## Bonus (optional)

- Add CloudWatch alarms for EC2 CPU/disk or Kafka consumer lag
- Handle schema evolution — add a column to the DB and show the Iceberg table updates automatically
