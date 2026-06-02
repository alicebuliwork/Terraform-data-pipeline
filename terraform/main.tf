module "networking" {
  source = "./modules/networking"
}

module "database" {
  source = "./modules/database"

  subnet_id = module.networking.subnet_id
}

module "kafka" {
  source = "./modules/kafka"

  subnet_id = module.networking.subnet_id
}

module "s3tables" {
  source = "./modules/s3tables"
}