locals {
  connection = "ssh ${var.user}@${libvirt_domain.this_domain.network_interface.0.addresses[0]}"
}

output "ssh" {
  value = local.connection
}

output "user" {
  value = var.user
}

output "ip" {
  value = libvirt_domain.this_domain.network_interface.0.addresses[0]
}
