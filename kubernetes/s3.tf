resource "aws_s3_bucket" "state_store" {
  bucket        = "${var.domain}-${var.env}-state"
  acl           = "private"
  force_destroy = true

  versioning {
    enabled = true
  }

  tags {
    Name        = "${var.domain}-${var.env}-state-store"
    Infra       = "${var.domain}"
    Environment = "${var.env}"
    Terraformed = "true"
  }
}