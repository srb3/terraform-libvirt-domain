# Will create 1 libvirt domain, running ubuntu 20.20
# The ssh user will be cloud
# The ssh public key will be taken from ~/.ssh/id_rsa.pub
# The disk size will be the smallest supported by the image
# The memory will be 1GB
# The number of vcpu's will be 1
# All of these values are the defaults and can be overriden
# Currently their is the choice of CentOS (6 - 8) or Ubuntu (16.04 - 20.20) operating systems
provider "libvirt" {
  uri = "qemu:///system"
}

module "libvirt_domain_default_settings" {
  unique_libvirt_domain_name = false # use the hostname as domain name - easier for testing
  source                     = "../../"
}
