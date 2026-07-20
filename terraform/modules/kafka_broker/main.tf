resource "aws_key_pair" "kafka_key" {
  key_name   = "kafka-ec2-key"
  public_key = file("${path.root}/.ssh/id_rsa.pub") # Path to your local public key file
}

resource "aws_instance" "kafka_broker" {
  ami                         = "ami-068b5bc67e48209c1" # Ubuntu 24.04 LTS in eu-north-1
  instance_type               = "t3.medium"             # Confluent CP-Server needs at least 4GB RAM
  subnet_id                   = var.public_subnet_id     # Make sure this points to your public subnet
  vpc_security_group_ids      = [aws_security_group.kafka_broker_sg.id]
  key_name                    = aws_key_pair.kafka_key.key_name
  associate_public_ip_address = true                    # Hands it an external route IP

  # Passes your docker configuration into the bootstrap shell engine
  user_data = templatefile("${path.module}/templates/kafka_user_data.sh.tpl", {})

  tags = {
    Name = "kafka-confluent-broker"
  }
}

resource "aws_instance" "kafka_broker" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.sg_id]
  key_name               = aws_key_pair.kafka_key.key_name

  # Startup Script to install and configure PostgreSQL

  user_data = templatefile("./${path.module}/user_data.sh", {})

  tags = {
    Name = var.tag
  }
}