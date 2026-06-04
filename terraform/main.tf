/*
module "networking" {
  source = "./modules/networking"

  vpc_cidr            = "10.0.0.0/16"
  vpc_name            = "dev-vpc"
  private_subnet_cidr = "10.0.1.0/24"
}
module "kafka" {
  source = "./modules/kafka"
  subnet_id = module.networking.private_subnet_id
  ami_id = "ami-00263659a97a6c29c"
}
*/
module "s3tables"{
  source = "./modules/s3tables"
  bucket_name = "alice-orders-table"
  namespace   = "orders"
}
