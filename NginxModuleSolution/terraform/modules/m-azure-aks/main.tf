resource "azurerm_kubernetes_cluster" "aks" {
  location                = var.location
  name                    = "${var.cluster_name}${var.location}"
  resource_group_name     = var.rg_name
  dns_prefix              = var.dns_prefix
  private_cluster_enabled = true
  
  tags                = {
    Environment = "Nginx Demo"
  }

  default_node_pool {
    name            = "agentpool"
    vm_size         = "Standard_F4s_v2"
    node_count      = var.agent_count
    os_disk_size_gb = 30
    vnet_subnet_id  = var.service_subnet_id
  }

  linux_profile {
    admin_username = "ubuntu"

    ssh_key {
      key_data = file(var.ssh_public_key)
    }
  }

  network_profile {
    network_plugin    = "kubenet"
    load_balancer_sku = "standard"
  }

  identity {
    type = "SystemAssigned"
  }

}
