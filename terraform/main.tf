

module "ec2"{
  source = "./modules/ec2"
  ami_id = "ami-068b5bc67e48209c1"
  tag = "try"
  instance_type = "t2.micro"
}
