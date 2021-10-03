# Will create 1 libvirt domain, running ubuntu 21.04
# The ssh user will be cloud
# The ssh public key will be taken from ~/.ssh/id_rsa.pub
# The disk size will be the ~40GB
# The memory will be 1GB
# The number of vcpu's will be 1
provider "libvirt" {
  uri = "qemu:///system"
}

resource "libvirt_volume" "ubuntu_base" {
  name   = "ubuntu_base_21.04"
  pool   = "default"
  source = "https://cloud-images.ubuntu.com/releases/hirsute/release/ubuntu-21.04-server-cloudimg-amd64-disk-kvm.img"
}

resource "libvirt_volume" "ubuntu_main" {
  name           = "ubuntu_main"
  pool           = "default"
  size           = 40000000000
  base_volume_id = libvirt_volume.ubuntu_base.id
}

module "libvirt_domain_with_attached_main_vol" {
  unique_libvirt_domain_name = false # use the hostname as domain name - easier for testing
  source                     = "../../"
  hostname                   = "ubuntu-mainvol"
  pool                       = "default"
  main_volume_id             = libvirt_volume.ubuntu_main.id
  main_volume_name           = "ubuntu_main"
}

########### Testing data #########################

# The local variables and the module below are
# used to generate test data for this example.
# They are not needed for the core libvirt
# functionality
locals {
  attributes = {
    expected_hostname   = "ubunti-mainvol"
    expected_os_family  = "debian"
    expected_os_name    = "ubuntu"
    expected_os_version = "21.04"
    expected_disk_size  = 40000000
    expected_memory     = 1000000
    expected_vcpu       = 1
  }
}

module "attributes" {
  source     = "../test_attributes"
  data       = yamlencode(local.attributes)
  test_suite = "main_volume"
}
