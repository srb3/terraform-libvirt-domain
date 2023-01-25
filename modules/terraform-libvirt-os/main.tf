locals {
  os = {
    "ubuntu" = {
      "latest" = "https://cloud-images.ubuntu.com/lunar/current/lunar-server-cloudimg-amd64-disk-kvm.img",
      "23.04"  = "https://cloud-images.ubuntu.com/lunar/current/lunar-server-cloudimg-amd64-disk-kvm.img",
      "22.10"  = "https://cloud-images.ubuntu.com/kinetic/current/kinetic-server-cloudimg-amd64-disk-kvm.img",
      "21.04"  = "https://cloud-images.ubuntu.com/releases/hirsute/release/ubuntu-21.04-server-cloudimg-amd64-disk-kvm.img",
      "20.10"  = "https://cloud-images.ubuntu.com/releases/groovy/release/ubuntu-20.10-server-cloudimg-amd64-disk-kvm.img",
      "20.04"  = "https://cloud-images.ubuntu.com/releases/focal/release/ubuntu-20.04-server-cloudimg-amd64-disk-kvm.img",
      "19.04"  = "https://cloud-images.ubuntu.com/releases/disco/release/ubuntu-19.04-server-cloudimg-amd64.img",
      "18.04"  = "https://cloud-images.ubuntu.com/releases/bionic/release/ubuntu-18.04-server-cloudimg-amd64.img",
      "17.04"  = "http://cloud-images-archive.ubuntu.com/releases/zesty/release-20171208/ubuntu-17.04-server-cloudimg-amd64.img",
      "16.04"  = "https://cloud-images.ubuntu.com/releases/xenial/release/ubuntu-16.04-server-cloudimg-amd64-disk1.img"
    },
    "centos" = {
      "latest"   = "https://cloud.centos.org/centos/8/x86_64/images/CentOS-8-GenericCloud-8.4.2105-20210603.0.x86_64.qcow2",
      "8"        = "https://cloud.centos.org/centos/8/x86_64/images/CentOS-8-GenericCloud-8.4.2105-20210603.0.x86_64.qcow2",
      "8-stream" = "https://cloud.centos.org/centos/8-stream/x86_64/images/CentOS-Stream-GenericCloud-8-20201217.0.x86_64.qcow2",
      "7"        = "https://cloud.centos.org/centos/7/images/CentOS-7-x86_64-GenericCloud-2009.qcow2",
      "6"        = "https://cloud.centos.org/centos/6/images/CentOS-6-x86_64-GenericCloud.qcow2"
    }
  }
}
