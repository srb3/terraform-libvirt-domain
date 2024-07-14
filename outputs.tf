locals {
  ip = var.network_config == "" ? libvirt_domain.this_domain.network_interface.0.addresses[0] : ""
  connection = "ssh ${var.user}@${local.ip}"
}

output "ssh" {
  value = local.connection
}

output "user" {
  value = var.user
}

output "ip" {
  value = var.network_config == "" ? local.ip : ""
}
