# Will create 1 libvirt domain, running CentOS 8
# The ssh user will be jdoe
# The ssh public key will be taken from ~/.ssh/id_rsa.pub
# The disk size will be ~40GB
# The memory will be ~4GB
# The number of vcpu's will be 2
provider "libvirt" {
  uri = "qemu:///system"
}

module "libvirt_domain_override_settings" {
  source                     = "../.."
  hostname                   = "centos-domain"
  user                       = "msmith"
  os_name                    = "centos"
  os_version                 = "8"
  disk_size                  = 50000000000
  memory                     = 4096
  vcpu                       = 2
  unique_libvirt_domain_name = false # use hostname as domain - easier for testing
}

output "centos_ssh" {
  value = module.libvirt_domain_override_settings.ssh
}

########### Testing data #########################

# The local variables and the module below are
# used to generate test data for this example.
# They are not needed for the core libvirt
# functionality
locals {
  attributes = {
    expected_hostname   = "centos-domain"
    expected_os_family  = "redhat"
    expected_os_name    = "centos"
    expected_os_version = "8.3.2011"
    expected_disk_size  = 40000000
    expected_memory     = 3500000
    expected_vcpu       = 2
  }
}

module "attributes" {
  source     = "../test_attributes"
  data       = yamlencode(local.attributes)
  test_suite = "override"
}

resource "null_resource" "sync_docker_files" {
  connection {
    type        = "ssh"
    user        = "msmith"
    private_key = file("~/.ssh/id_rsa")
    host        = module.libvirt_domain_override_settings.ip
    agent       = false
    timeout     = "60s"
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'waited for connection' > /tmp/connection"
    ]
  }
  depends_on = [module.libvirt_domain_override_settings]
}
