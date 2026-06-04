resource "aws_s3tables_table_bucket" "this" {
  name = var.bucket_name
}

resource "aws_s3tables_namespace" "this" {
  table_bucket_arn = aws_s3tables_table_bucket.this.arn
  namespace        = var.namespace
}

resource "aws_s3tables_table" "orders" {
  table_bucket_arn = aws_s3tables_table_bucket.this.arn
  namespace         = aws_s3tables_namespace.this.namespace
  name              = "orders"

  format = "ICEBERG"

  metadata {
    iceberg {
      schema {
        field {
            name = "id"
            type = "string" 
        }
        field {
            name = "customer_name"
            type = "string"
        }
        field {
            name = "amount"
            type = "long"
        }
        field {
            name = "status"
            type = "string"
        }
        field {
            name = "created_at"
            type = "timestamp"
        }
        # CDC fields

        field {
            name = "__op"
            type = "string"
        }
        field {
            name = "__source_ts"
            type = "timestamp"
        }
      }  
    }
  }

}