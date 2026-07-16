resource "aws_instance" "postgres_server" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.sg_id

  # Startup Script to install and configure PostgreSQL

  user_data = templatefile("${path.module}/user_data.sh", {
    db_password = var.db_password
  })

  tags = {
    Name = var.tag
  }
}