resource "azurerm_public_ip" "public_ip" {
  name                = "${var.vm_prefix}${var.location}-public-ip"
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Dynamic"
  tags = {
    environment = "Nginx Demo"
  }
}

resource "azurerm_network_interface" "main" {
  name                = "${var.vm_prefix}${var.location}-nic"
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "${var.vm_prefix}${var.location}-ip"
    subnet_id                     = var.service_subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }

  enable_ip_forwarding = true
}

resource "azurerm_network_security_group" "main" {
  name                = "${var.vm_prefix}${var.location}-sg"
  location            = var.location
  resource_group_name = var.rg_name

  security_rule {
    name                       = "ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "Nginx Demo"
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "main" {
  network_interface_id      = azurerm_network_interface.main.id
  network_security_group_id = azurerm_network_security_group.main.id
}

resource "azurerm_virtual_machine" "main" {
  name                  = "${var.vm_prefix}${var.location}-vm"
  location              = var.location
  resource_group_name   = var.rg_name
  network_interface_ids = [azurerm_network_interface.main.id]
  vm_size               = "Standard_DS1_v2"

  delete_os_disk_on_termination = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "nginxinc"
    offer     = "nginx-plus-v1-standard"
    sku       = "nginx-plus-ubuntu2204"
    version   = "latest"
  }

  plan {
    name      = "nginx-plus-ubuntu2204"
    publisher = "nginxinc"
    product   = "nginx-plus-v1-standard"
  }

  storage_os_disk {
    name              = "${var.vm_prefix}${var.location}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      key_data  = file(var.ssh_public_key)
      path      = "/home/${var.admin_user}/.ssh/authorized_keys"
    }
  }

  os_profile {
    computer_name = var.vm_prefix
    admin_username = var.admin_user
    custom_data = var.custom_data
  }

  tags = {
    environment = "Nginx Demo"
  }
}
