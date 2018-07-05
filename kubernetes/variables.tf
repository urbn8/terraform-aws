variable "aws_region" {
  description = "Region for the VPC"
  default = "eu-central-1"
}
variable "zones" {
  description = "Available zone"
  default = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
}

variable "env" {
  description = "Environment"
  default = "staging"
}
variable "domain" {
  default = "urbn8.com"
}
