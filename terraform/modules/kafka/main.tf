resource "aws_instance" "kafka_vm" {
  ami           = "var.ami_id"
  instance_type = "t3.micro"
  subnet_id = var.subnet_id

  tags = {
    Name = "terraform-free-tier-ec2"
  }
}