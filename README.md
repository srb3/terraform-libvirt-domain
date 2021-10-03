# terraform-libvirt-domain

A terraform module for provisioning linux libvirt domains

## Usage

### Using module defaults

The following will create an Ubuntu 20.10 VM with 1 VCPU, 1GB of RAM and
a 20GB disk. The ssh user will be cloud with the public key for that users
authorized_keys file being read from ~/.ssh/id_rsa.pub

```HCL
module "my-domain" {
  source   = "srb3/domain/libvirt"
  hostname = "webapp1"
  user     = "cloud"
}
```

### Overrding most defaults

```HCL
module "my-domain" {
  source         = "srb3/domain/libvirt"
  hostname       = "db1"
  user           = "jdoe"
  ssh_public_key = "~/.ssh/id_rsa.pub"
  os_name        = "centos"
  os_version     = "latest"
  disk_size      = 40000000000
  memory         = 4096
  vcpu           = 4
  autostart      = true
}
```

## Testing

This module uses [cinc-auditor](https://cinc.sh/start/auditor/) as a test framework.
To install you can use the [download page](https://cinc.sh/download/) and the
[getting started guid](https://cinc.sh/start/auditor/). The auditor test are
located in the [test --> integration directory](./test/integration).
There is a [make file](./Makefile)
in the root of the repo that takes care of orchestrating the tests
