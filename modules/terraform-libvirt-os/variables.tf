variable "os_name" {
  description = "The name of the operating system to create"
  type        = string
  default     = "ubuntu"
}

variable "os_version" {
  description = "The version of the operationg system to use"
  type        = string
  default     = "latest"
}
