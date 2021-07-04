# Will create 1 libvirt domain, running CentOS 8
# The ssh user will be jdoe
# The ssh public key will be taken from ~/.ssh/id_rsa.pub
# The disk size will be ~40GB
# The memory will be ~4GB
# The number of vcpu's will be 2
provider "libvirt" {
  uri = "qemu:///system"
}

#module "libvirt_domain_override_settings" {
#  source                     = "../.."
#  hostname                   = "testdomain"
#  user                       = "jdoe"
#  os_name                    = "centos"
#  os_version                 = "8"
#  disk_size                  = 40000000000
#  memory                     = 4096
#  vcpu                       = 2
#  unique_libvirt_domain_name = false # use hostname as domain - easier for testing
#}

module "libvirt_domain_override_settings" {
  source                     = "../.."
  hostname                   = "testdomain"
  user                       = "jdoe"
  os_name                    = "ubuntu"
  os_version                 = "20.04"
  disk_size                  = 40000000000
  memory                     = 4096
  vcpu                       = 2
  unique_libvirt_domain_name = false # use hostname as domain - easier for testing
}

output "ssh" {
  value = module.libvirt_domain_override_settings.ssh
}
