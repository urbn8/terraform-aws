terraform {
  backend "s3" {
    bucket = "gsviec-terraform"
    key    = "kubernetes/terraform.tfstate"
    region = "eu-central-1"
  }
}
