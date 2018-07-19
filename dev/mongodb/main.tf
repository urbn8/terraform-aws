terraform {
  backend "s3" {
    bucket = "terraform-staging-urbn8.io"
    key    = "mongodb/terraform-dev.tfstate"
    region = "eu-central-1"
  }
}

module "mongodb" {
  source               = "../../modules/mongodb"
  environment          = "dev"
  domain               = "urbn8.io"
  vpc_id               = "vpc-efc99484"
  dns_zone             = "Z14R93S7FNVUY1"
  mongo_security_group = ["sg-3871dc54", "sg-014ce16d"]
  ssh_security_group   = ["sg-014ce16d"]

  # Allow each node can access mongodb
  bastion_security_group = "sg-3871dc54"
  key_name               = "frankfurt"
  private_subnets        = ["subnet-2b616140", "subnet-4b9de236", "subnet-82216ccf"]
  vol_size               = "10"
}

module "slack" {
  source                = "../../modules/slack"
  slack_message_deploy  = "Deploy or update the mongodb at time: ${timestamp()}"
  slack_message_destroy = "Destroy the mongodb at time: ${timestamp()}"
}

output "mongodb-url" {
  value = "${module.mongodb.mongodb-url}"
}
