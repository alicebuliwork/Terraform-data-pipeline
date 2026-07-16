variable "aws_region" {
  type        = string
  description = "The AWS Region where the resources will be deployed."
  default     = "us-east-1"
}

variable "ami_id" {
  type        = string
  description = "The AMI ID to use for the PostgreSQL EC2 instance (Default is Ubuntu 24.04 LTS in us-east-1)."
  default     = "ami-080e1f13689e07408" # Replace this if you change your target aws_region
}

