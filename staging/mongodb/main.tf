terraform {
  backend "s3" {
    bucket = "terraform-staging-urbn8.io"
    key    = "mongodb/terraform.tfstate"
    region = "eu-central-1"
  }
}

module "mongodb" {
  source                 = "../../modules/mongodb"
  environment            = "staging"
  domain                 = "urbn8.io"
  vpc_id                 = "vpc-efc99484"
  dns_zone               = "ZTSLDH58UVUDZ"
  ami_id                 = "ami-0adbe2a35a4b9fb93"
  vpc_security_group_ids = ["sg-a77cd1cb", "sg-014ce16d", "sg-3871dc54", "sg-05ec5a4c8be661b91"]

  instance_type = "c4.large"
  key_name      = "frankfurt"
  subnet_ids    = ["subnet-c35f5fa8", "subnet-aea5dad3", "subnet-77115c3a"]
  vol_size      = "10"
  root_vol_size = "20"
}

module "slack" {
  source                = "../../modules/slack"
  slack_message_deploy  = "Deploy or update the mongodb at time: ${timestamp()}"
  slack_message_destroy = "Destroy the mongodb at time: ${timestamp()}"
}

output "mongodb-url" {
  value = "${module.mongodb.mongodb-url}"
}
