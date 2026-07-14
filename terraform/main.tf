module "iam"{
  source = "./modules/iam"
  user_name = "alice-user"
}


module "s3tables"{
  source = "./modules/s3tables"
  bucket_name = "alice-orders-table"
  namespace   = "orders"

  depends_on = [module.iam]
}
