
resource "azurerm_resource_group" "rg1" {
  location = var.resource_group_location
  name     = var.resource_group_name_prefix
}

module "vnet1" {
  source = "../modules/m-azure-vnet"
  location  =  azurerm_resource_group.rg1.location
  rg_name   = azurerm_resource_group.rg1.name
}

module "aks1" {
  source            = "../modules/m-azure-aks"
  location          = azurerm_resource_group.rg1.location
  rg_name           = azurerm_resource_group.rg1.name
  service_subnet_id = module.vnet1.service_subnet_id
}

module "vm1" {
  source            = "../modules/m-azure-vm"
  location          = azurerm_resource_group.rg1.location
  rg_name           = azurerm_resource_group.rg1.name
  service_subnet_id = module.vnet1.service_subnet_id 
  ssh_public_key    = var.ssh_public_key
}


output "cluster_name" {
  depends_on = [
    module.aks1
  ]
  value = module.aks1.cluster_name
}

output "cluster_private_fqdn" {
  depends_on = [
    module.aks1
  ]
  value = module.aks1.private_fqdn
}

output "nginx_public_ip_address" {
  depends_on = [
    module.vm1,
    module.aks1
  ]
  value = module.vm1.public_ip
}