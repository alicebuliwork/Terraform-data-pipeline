
module "vpc"{
  source = "./modules/vpc"
  aws_region = var.region
  ami_id = "ami-068b5bc67e48209c1"
}


module "postgres_ec2"{
  source = "./modules/postgres_ec2"
  ami_id = "ami-068b5bc67e48209c1"
  tag = "postgres_server"
  instance_type = "t3.micro"
  vpc_id = module.vpc.vpc_id
  subnet_id = module.vpc.public_subnet_id
  sg_id = module.vpc.sg_id
  db_password = "postgres"
}


