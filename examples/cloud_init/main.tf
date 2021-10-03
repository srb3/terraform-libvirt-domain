provider "libvirt" {
  uri = "qemu:///system"
}

locals {
  user_data_script = templatefile("${path.module}/templates/cloud-init.sh", {
    hostname            = "ubuntu-0"
    user_name           = "jdoe"
    ssh_user_public_key = file("~/.ssh/id_rsa.pub")
  })
}

module "ubuntu_0" {
  source                     = "../.."
  hostname                   = "ubuntu-0"
  user                       = "jdoe"
  os_name                    = "ubuntu"
  os_version                 = "21.04"
  disk_size                  = 40000000000
  memory                     = 4096
  vcpu                       = 2
  unique_libvirt_domain_name = false # use hostname as domain - easier for testing
  user_cloudinit             = local.user_data_script
}

########### Testing data #########################

# The local variables and the module below are
# used to generate test data for this example.
# They are not needed for the core libvirt
# functionality
locals {
  attributes = {
    expected_hostname        = "ubuntu-0"
    expected_os_family       = "debian"
    expected_os_name         = "ubuntu"
    expected_os_version      = "21.04"
    expected_disk_size       = 40000000
    expected_memory          = 4000000
    expected_vcpu            = 2
    expected_packages        = ["docker-ce", "docker-ce-cli", "containerd.io"]
    expected_dirs            = ["/home/jdoe/.ssh"]
    expected_services        = ["docker"]
    expected_container_image = "postgres:latest"
    expected_container_name  = "postgres-test"
    expected_container_tag   = "latest"
    expected_container_repo  = "postgres"
  }
}

module "attributes" {
  source     = "../test_attributes"
  data       = yamlencode(local.attributes)
  test_suite = "cloud_init"
}
