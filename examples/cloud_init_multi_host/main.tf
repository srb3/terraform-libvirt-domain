provider "libvirt" {
  uri = "qemu:///system"
}

locals {
  user_data_script = templatefile("${path.module}/templates/cloud-init.sh", {})
}


module "ubuntu_0" {
  source                     = "../.."
  hostname                   = "ubuntu-0"
  user                       = "jdoe"
  os_name                    = "ubuntu"
  os_version                 = "20.04"
  disk_size                  = 40000000000
  memory                     = 4096
  vcpu                       = 2
  unique_libvirt_domain_name = false # use hostname as domain - easier for testing
  user_cloudinit             = user_data_script
}

module "ubuntu_1" {
  source                     = "../.."
  hostname                   = "ubuntu-1"
  user                       = "jdoe"
  os_name                    = "ubuntu"
  os_version                 = "20.04"
  disk_size                  = 40000000000
  memory                     = 4096
  vcpu                       = 2
  unique_libvirt_domain_name = false # use hostname as domain - easier for testing
  user_cloudinit             = user_data_script
}


