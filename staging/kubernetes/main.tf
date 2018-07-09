terraform {
  backend "s3" {
    bucket = "terraform-staging-urbn8.io"
    key    = "kubernetes/terraform.tfstate"
    region = "eu-central-1"
  }
}

module "s3" {
  source = "../../modules/s3"
  environment = "staging"
  domain = "urbn8.io"
  s3_bucket="kubernetes-staging-urbn8.io"
}

# module "slack" {
# 	source = "../../modules/slack"
# 	slack_message_deploy = "Deploy or update the VPC:${module.vpc.vpc_id} at time: ${timestamp()}"
# 	slack_message_destroy = "Destroy the VPC:${module.vpc.vpc_id} at time: ${timestamp()}"

# }