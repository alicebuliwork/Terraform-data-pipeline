resource "aws_instance" "kafka_vm" {
  ami           = var.ami_id
  instance_type = "t3.micro"
  subnet_id = var.subnet_id

  user_data = file("${path.module}/kafka-install.sh")

  tags = {
    Name = "terraform-free-tier-ec2"
  }
}