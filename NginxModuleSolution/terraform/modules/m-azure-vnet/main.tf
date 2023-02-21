resource "azurerm_virtual_network" "vnet1" {
    name                = "nginx-module-net-${var.location}"
    location            = var.location
    resource_group_name = var.rg_name
    address_space       = ["10.10.0.0/16"]

    tags = {
        environment = "Nginx Demo"
    }
}

resource "azurerm_subnet" "service-subnet" {
    name                 = "nginx-module-srv-snet-${var.location}"
    resource_group_name  = var.rg_name
    virtual_network_name = azurerm_virtual_network.vnet1.name
    address_prefixes     = ["10.10.0.0/24"]
}

resource "azurerm_subnet" "app-subnet" {
    name                 = "nginx-module-app-snet-${var.location}"
    resource_group_name  = var.rg_name
    virtual_network_name = azurerm_virtual_network.vnet1.name
    address_prefixes     = ["10.10.1.0/24"]
}