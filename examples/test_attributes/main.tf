locals {

  # The attrs variable is a yaml data structure holding
  # the config for the cinc-auditor and python selenium tests
  attrs = templatefile("${path.module}/templates/attrs", {
    data = var.data
  })
}

# This file is only used by the testing scripts
# It acts as config and is not executable
resource "local_file" "attrs_create" {
  content         = local.attrs
  filename        = "${path.root}/../../test/integration/${var.test_suite}/attrs.yml"
  file_permission = "0644"
}
