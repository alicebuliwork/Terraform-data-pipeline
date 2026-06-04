terraform {
  backend "s3" {
    bucket         = "aws-alice-terraform-bucket"
    key            = "terraform-data-pipeline/terraform.tfstate"
    region         = "eu-north-1"
    use_lockfile   = true
  }
}