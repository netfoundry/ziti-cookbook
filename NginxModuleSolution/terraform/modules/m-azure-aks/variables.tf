variable "agent_count" {
  default = 1
}

variable "cluster_name" {
  default = "akssand"
}

variable "dns_prefix" {
  default = "akssand"
}

variable "location" {}
variable "rg_name" {}
variable "service_subnet_id" {}

variable "ssh_public_key" {
  default = "~/.ssh/id_rsa.pub"
}

