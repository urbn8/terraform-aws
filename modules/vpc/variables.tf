variable "aws_region" {
  description = "Region for the VPC"
  default = "eu-central-1"
}

# Ubuntu Precise 16.04 LTS (x64)
variable "aws_amis" {
  default = {
    eu-west-1 = "ami-674cbc1e"
    us-east-1 = "ami-a4dc46db"
    us-west-1 = "ami-969ab1f6"
    us-west-2 = "ami-8803e0f0"
    eu-central-1= "ami-c7e0c82c"
  }
}



variable "zones" {
  description = "Available zone"
  default = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
}
# variable "vpc_cidr" {
#   description = "CIDR for the VPC"
#   default = "10.0.0.0/16"
# }
# variable "vpc_private_subnets" {
#   default = ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24"]
# }
# variable "vpc_public_subnets" {
#   default = ["10.10.11.0/24", "10.10.12.0/24", "10.10.13.0/24"]
# }

variable "vpc_cidr" {
  description = "CIDR for the VPC"
  default = "172.31.0.0/16"
}
variable "vpc_private_subnets" {
  default = ["172.31.48.0/20", "172.31.64.0/20", "172.31.80.0/20"]
}
variable "vpc_public_subnets" {
  default = ["172.31.16.0/20", "172.31.0.0/20", "172.31.32.0/20"]
}

variable "office-subnets" {
  default = ["192.168.9.0/24", "192.168.10.0/24"]
}

variable "office-static" {
  default = ["112.197.14.10/32"]
}

variable "storm-clutser-subnets" {
  description = "Storm cluster"
  default = ["112.197.14.10/32"]
}

variable "customer_gateway" {
  description = "Customer gateway"
}

variable "key_path" {
  description = "SSH Public Key path"
  default = "~/.ssh/id_rsa.pub"
}

variable "environment" {
  description = "Environment"
  default = "staging"
}
variable "domain" {
  description = "Domain for environment"
  default = "urbn8.com"
}
# variable "db_remote_state_bucket" {
#   description = "The name of the S3 bucket for the database's remote state"
# }

# variable "db_remote_state_key" {
#   description = "The path for the database's remote state in S3"
# }