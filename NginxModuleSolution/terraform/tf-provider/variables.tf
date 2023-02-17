variable "resource_group_location" {
  default     = "eastus"
  description = "Location of the resource group."
}

variable "resource_group_name_prefix" {
  default     = "nginx_module_rg"
  description = "Prefix of the resource group name"
}

variable "nginx-ziti-module" {
  default = "nginx-ziti-module"
}
variable "ssh_public_key" {
  default = "~/.ssh/id_rsa.pub"
}

