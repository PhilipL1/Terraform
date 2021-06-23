// Virtual Network
resource "azurerm_virtual_network" "main" {
    name                = "${var.project_name}-vnet"
    address_space       = ["10.0.0.0/16"]
    location            = var.location
    resource_group_name = var.group_name
}
// Public Subnet with NSG allowing SSH from everywhere (attach rules and allow to change traffic (give ports rules)) subnet for each vm
resource "azurerm_subnet" "main" {
    name                 = "internal"
    resource_group_name  = var.group_name
    virtual_network_name = azurerm_virtual_network.main.name
    address_prefixes     = ["10.0.2.0/24"]
}

// Private Subnet with NSG allowing SSH only from public subnet
resource "azurerm_network_interface" "private" {
    name                = "${var.project_name}-nic-public"
    location            = var.location
    resource_group_name = var.group_name

    ip_configuration {
        name                          = "internal"
        subnet_id                     = azurerm_subnet.main.id
        private_ip_address_allocation = "Dynamic"
    }
}
// Network Interface
resource "azurerm_network_interface" "public" { # public resource vnet- both 
  name                = "${var.project_name}-nic-private"
    location            = var.location
    resource_group_name = var.group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.main.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.public.id
  }
}

// Public IP
resource "azurerm_public_ip" "public" {
    name                = "${var.project_name}_publicIP"
    location            = var.location
    resource_group_name = var.group_name
  
  allocation_method   = "Static"
}

// Network Security Group
resource "azurerm_network_security_group" "public" {
    name                = "${var.project_name}_nsg_public"
    location            = var.location
    resource_group_name = var.group_name

  security_rule {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_security_group" "private" {
    name                = "${var.project_name}_nsg_private"
    location            = var.location
    resource_group_name = var.group_name

  security_rule {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "10.0.0.0/8"# find private ip 
    destination_address_prefix = "*"
  }
}
