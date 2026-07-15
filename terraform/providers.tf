terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # Downloads the latest 5.x version of the AWS plugin
    }
  }
  backend "s3" {
    bucket         = "aws-alice-terraform-bucket"
    key            = "terraform-data-pipeline/terraform.tfstate"
    region         = "eu-north-1"
    use_lockfile   = true
    encrypt        = true
  }
}

provider "aws" {
  region = var.region
}
