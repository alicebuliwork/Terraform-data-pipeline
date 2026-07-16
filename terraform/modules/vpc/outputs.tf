output "vpc_id" {
  value       = aws_vpc.main_vpc.id
  description = "The ID of the main VPC"
}

output "public_subnet_id" {
  value       = aws_subnet.public_subnet.id
  description = "The ID of the public subnet"
}

output "sg_id" {
  value       = aws_security_group.debug_sg.id
  description = "The ID of the security group"
}