resource "aws_instance" "free_server" {
  ami           = var.ami_id
  instance_type = var.instance_type

  tags = {
    Name = var.tag
  }
}