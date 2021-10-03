# Will create 1 libvirt domain, running ubuntu 21.04
# The ssh user will be cloud
# The ssh public key will be taken from ~/.ssh/id_rsa.pub
# The disk size will be the smallest supported by the image
# The memory will be 1GB
# The number of vcpu's will be 1
# All of these values are the defaults and can be overriden
# Currently there is the choice of CentOS (6 - 8) or Ubuntu (16.04 - 20.20) operating systems
provider "libvirt" {
  uri = "qemu:///system"
}

module "libvirt_domain_default_settings" {
  unique_libvirt_domain_name = false # use the hostname as domain name - easier for testing
  source                     = "../../"
}

########### Testing data #########################

# The local variables and the module below are
# used to generate test data for this example.
# They are not needed for the core libvirt
# functionality
locals {
  attributes = {
    expected_hostname   = "libvirthost"
    expected_os_family  = "debian"
    expected_os_name    = "ubuntu"
    expected_os_version = "21.04"
    expected_disk_size  = 20000000
    expected_memory     = 1000000
    expected_vcpu       = 1
  }
}

module "attributes" {
  source     = "../test_attributes"
  data       = yamlencode(local.attributes)
  test_suite = "default"
}
