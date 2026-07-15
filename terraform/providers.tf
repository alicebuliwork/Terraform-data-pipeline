terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0" # Downloads the latest 5.x version of the AWS plugin
    }
  }
}

provider "aws" {
  region = var.region
}
