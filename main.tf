resource "random_id" "uuid" {
  byte_length = 4
  prefix      = "${var.os_name}-${var.os_version}"
}

module "os" {
  source     = "./modules/terraform-libvirt-os"
  os_name    = var.os_name
  os_version = var.os_version
}

locals {
  uuid               = random_id.uuid.b64_url
  cloudinit_iso_name = "${local.uuid}.iso"
  base_volume_name   = "${local.uuid}-base-vol"
  main_volume_name   = "${local.uuid}-main-vol"
  domain_name        = "${local.uuid}-domain"
  local_cloudinit = templatefile("${path.module}/templates/cloud_init.cfg", {
    hostname       = var.hostname
    user           = var.user
    ssh_public_key = chomp(file(var.ssh_public_key))
  })
  cloudinit = var.user_cloudinit != "" ? var.user_cloudinit : local.local_cloudinit
}

resource "libvirt_cloudinit_disk" "commoninit" {
  name      = local.cloudinit_iso_name
  user_data = local.cloudinit
}

resource "libvirt_volume" "this_base_volume" {
  count  = var.base_volume_name == "" ? var.main_volume_name == "" ? 1 : 0 : 0
  name   = local.base_volume_name
  pool   = var.pool
  source = var.os_cached_image == "" ? module.os.url : var.os_cached_image
  format = "qcow2"
}

resource "libvirt_volume" "this_main_volume" {
  count          = var.main_volume_name == "" ? 1 : 0
  name           = local.main_volume_name
  base_volume_id = var.base_volume_id != "" ? var.base_volume_id : libvirt_volume.this_base_volume[0].id
  pool           = var.pool
  size           = var.disk_size
}

resource "libvirt_domain" "this_domain" {
  name   = var.unique_libvirt_domain_name ? local.domain_name : var.hostname
  memory = var.memory
  vcpu   = var.vcpu

  network_interface {
    network_name   = var.network
    wait_for_lease = true
  }

  disk {
    volume_id = var.main_volume_id == "" ? libvirt_volume.this_main_volume[0].id : var.main_volume_id
  }

  cloudinit = libvirt_cloudinit_disk.commoninit.id

  console {
    type        = "pty"
    target_type = "serial"
    target_port = "0"
  }

  graphics {
    type        = "spice"
    listen_type = "address"
    autoport    = true
  }

}
