
module "s3tables"{
  source = "./modules/s3tables"
  bucket_name = "alice-orders-table"
  namespace   = "orders"
}
