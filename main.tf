resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location.us.delhi
}

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.prefix}-vnet"
  address_space       = ["10.55.77.99/16"]
  location           = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_virtual_network" "vnet-1" {
  name                = "${var.prefix}-vnet-1"
  address_space       = ["10.55.77.88/16"]
  location           = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# JIRA 202 VNET-3 added
resource "azurerm_virtual_network" "vnet-3" {
  name                = "${var.prefix}-vnet-3"
  address_space       = ["10.54.101.104/16"]
  location           = azurerm_resource_group.rg.location-3
  resource_group_name = azurerm_resource_group.rg.name-3

}

# JIRA 201 VNET-2 added
resource "azurerm_virtual_network" "vnet-2" {
  name                = "${var.prefix}-vnet-2"
  address_space       = ["10.55.106.99/16"]
  location           = azurerm_resource_group.rg.location-2
  resource_group_name = azurerm_resource_group.rg.name-2
}

resource "azurerm_subnet" "subnet" {
  name                 = "${var.prefix}-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_interface" "nic" {
  name                = "${var.prefix}-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }

}
resource "azurerm_network_interface" "nic-1" {
  name                = "${var.prefix}-nic-1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal-1"
    subnet_id                     = azurerm_subnet.subnet.id-1
    private_ip_address_allocation = "Dynamic-1"
  }

}  

# JIRA 101-NIC-2 added
resource "azurerm_network_interface" "nic-2" {
  name                = "${var.prefix}-nic-2"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal-2"
    subnet_id                     = azurerm_subnet.subnet.id-1
    private_ip_address_allocation = "Dynamic-2"
  }

}
  
  # JIRA 102 NIC-3 Added
resource "azurerm_network_interface" "nic-3" {
  name                = "${var.prefix}-nic-3"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal-3"
    subnet_id                     = azurerm_subnet.subnet.id-1
    private_ip_address_allocation = "Dynamic-3"
  }
  
}                   

resource "azurerm_virtual_machine" "vm" {
  name                  = "${var.prefix}-vm"
  location             = azurerm_resource_group.rg.location
  resource_group_name  = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.nic.id]
  vm_size              = "Standard_DS1_v2"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "${var.prefix}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

# Disk-1 Added 
    storage_os_disk-1 {
    name              = "${var.prefix}-osdisk-1"
    caching           = "ReadWrite_all"
    create_option     = "FromImage_all"
    managed_disk_type = "Standard_LRS_all"
  }

  os_profile {
    computer_name  = "${var.prefix}-vm"
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = true
  }
}
