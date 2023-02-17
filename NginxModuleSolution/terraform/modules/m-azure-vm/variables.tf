variable "location" {}
variable "rg_name" {}
variable "service_subnet_id" {}
variable "vm_prefix" {
  default = "aks-nginx"
}
variable "admin_user" {
  default = "ziggy"
}
variable "ssh_public_key" {}
variable "custom_data" {
  default = "#cloud-config\npackage_update: true\npackage_upgrade: true\npackage_reboot_if_required: true\npackages:\n- libpcre3-dev\n- libz-dev\n- libuv1-dev\n- cmake\n- build-essential\n- jq"
}