resource "aws_instance" "postgres_server" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.sg_id]
  key_name               = aws_key_pair.postgres_key.key_name

  # Startup Script to install and configure PostgreSQL

  user_data = templatefile("./${path.module}/user_data.sh", {
    db_password = var.db_password
    sql_content = file("${path.module}/init.sql")
  })

  tags = {
    Name = var.tag
  }
}

resource "aws_key_pair" "postgres_key" {
  key_name   = "postgres-ec2-key"
  public_key = file("${path.root}/.ssh/id_rsa.pub") # Path to your local public key file

}
