output "cluster_name" {
  value = "${var.env}.${var.domain}"
}

output "state_store" {
  value = "s3://${aws_s3_bucket.state_store.id}"
}
output "zones" {
  value = "${var.zones}"
}