output "table_bucket_arn" {
  value = aws_s3tables_table_bucket.this.arn
}

output "namespace" {
  value = aws_s3tables_namespace.this.namespace
}

output "table_name" {
  value = aws_s3tables_table.orders.name
}