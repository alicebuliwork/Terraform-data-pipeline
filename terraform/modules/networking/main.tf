resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "private" {
  vpc_id = aws_vpc.this.id

  cidr_block = var.private_subnet_cidr

  tags = {
    Name = "${var.vpc_name}-private-subnet"
  }
}