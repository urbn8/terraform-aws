output "cluster_name" {
  value = "${module.s3.cluster_name}"
}

output "state_store" {
  value = "${module.s3.state_store}"
}
output "zones" {
  value = "${module.s3.zones}"
}