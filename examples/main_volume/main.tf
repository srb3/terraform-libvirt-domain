provider "libvirt" {
  uri = "qemu:///system"
}

locals {
  user_data_script_0 = templatefile("${path.module}/templates/cloud-init.sh", {
    hostname       = "ubuntu-0"
    user           = "jdoe"
    ssh_public_key = chomp(file("~/.ssh/id_rsa.pub"))
  })
  user_data_script_1 = templatefile("${path.module}/templates/cloud-init.sh", {
    hostname       = "ubuntu-1"
    user           = "jdoe"
    ssh_public_key = chomp(file("~/.ssh/id_rsa.pub"))
  })
  user_data_script_2 = templatefile("${path.module}/templates/cloud-init.sh", {
    hostname       = "ubuntu-2"
    user           = "jdoe"
    ssh_public_key = chomp(file("~/.ssh/id_rsa.pub"))
  })
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
  user_cloudinit             = local.user_data_script_0
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
  user_cloudinit             = local.user_data_script_1
}

module "ubuntu_2" {
  source                     = "../.."
  hostname                   = "ubuntu-2"
  user                       = "jdoe"
  os_name                    = "ubuntu"
  os_version                 = "20.04"
  disk_size                  = 40000000000
  memory                     = 4096
  vcpu                       = 2
  unique_libvirt_domain_name = false # use hostname as domain - easier for testing
  user_cloudinit             = local.user_data_script_2
}

output "ubuntu_1" {
  value = module.ubuntu_1.ssh
}

output "ubuntu_0" {
  value = module.ubuntu_0.ssh
}
