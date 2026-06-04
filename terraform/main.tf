
module "s3tables"{
  source = "./modules/s3tables"
  bucket_name = "alice-orders-table"
  namespace   = "orders"
}
module "iam"{
  source = "./modules/iam"
  user_name = "alice-user"
}
