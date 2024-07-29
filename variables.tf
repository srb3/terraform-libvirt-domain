variable "hostname" {
  description = "The hostname to give to the system"
  type        = string
  default     = "libvirthost"
}

variable "user" {
  description = "The user to create on the target system"
  type        = string
  default     = "cloud"
}

variable "ssh_public_key" {
  description = "The path to a public key to use for the user specified"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "os_name" {
  description = "The name of the os to use"
  type        = string
  default     = "ubuntu"
}

variable "os_version" {
  description = "The version of the os to use"
  type        = string
  default     = "latest"
}

variable "os_cached_image" {
  description = "If the os image you wish to use is cached locally then set the path to it in this variable"
  type        = string
  default     = ""
}

variable "disk_size" {
  description = "the size of disk to use for the instance"
  type        = number
  default     = 20000000000
}

variable "memory" {
  description = "The ammout of memory to allocate"
  type        = string
  default     = "1024"
}

variable "vcpu" {
  description = "The number of vcpu's to allocate"
  type        = number
  default     = 1
}

variable "cpu_mode" {
  description = "The mode to use for the CPU"
  type        = string
  default     = "host-passthrough"
}

variable "pool" {
  description = "The name of the volume pool to use"
  type        = string
  default     = "default"
}

variable "network" {
  description = "The name of the network to use"
  type        = string
  default     = "default"
}

variable "unique_libvirt_domain_name" {
  description = <<EOT
    If set to true the name of the libvirt domain is generated from 
    os-name, os_version and a random id. If set to false the hostname
    is used as the libvirt domain name. The domain in question here is a libvirt domain:
      a domain is an instance of an operating system (https://libvirt.org/goals.html)
  EOT
  type        = bool
  default     = true
}

variable "user_cloudinit" {
  description = "A user defined cloudinit template rendered as a string"
  type        = string
  default     = ""
}

variable "network_config" {
  description = "A user defined cloudinit network config"
  type        = string
  default     = ""
}

variable "base_volume_id" {
  description = "If you want to use an existing base volume, set it's id here"
  type        = string
  default     = ""
}

variable "main_volume_id" {
  description = "If you want to use an existing main volume, set it's id here"
  type        = string
  default     = ""
}

variable "base_volume_name" {
  description = "If you want to use an existing base volume, set it's name here"
  type        = string
  default     = ""
}

variable "main_volume_name" {
  description = "If you want to use an existing main volume, set it's name here"
  type        = string
  default     = ""
}
variable "autostart" {
  description = "Set to true if you would like to have autostart endabled."
  type        = bool
  default     = false
}
