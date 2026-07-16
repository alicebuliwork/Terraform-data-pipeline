variable "ami_id" {
  type = string
}

variable "tag" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "vpc_id" {
  type        = string
  description = "The VPC ID where the security group should be created"
}

variable "subnet_id" {
  type        = string
  description = "The Subnet ID where the EC2 instance should be launched"
}

variable "sg_id" {
  type        = string
  description = "The Security Group ID"
}

variable "db_password" {
  type      = string
  sensitive = true
}