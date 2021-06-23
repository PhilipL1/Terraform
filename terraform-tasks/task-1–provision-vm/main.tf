// Terraform Config Block
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
}

// Provider
provider "azurerm" {
  features {}
}

// Resource Group
resource "azurerm_resource_group" "main" {
    name     = "${var.project_name}-rg"
    location = var.location
}

// Linux Virtual Machine
module "vm" {
    source        = "./vm"
    project_name  = var.project_name
    group_name    = azurerm_resource_group.main.name
    location      = var.location
    interface_ids = module.vnet.interface_ids
}
module "vnet" {
    source        = "./vnet"
    project_name  = var.project_name
    group_name    = azurerm_resource_group.main.name
    location      = var.location
}

# // k8s cluster 
# resource "azurerm_kubernetes_cluster" "main" {
#   name                = "example-aks1"
#   location            = azurerm_resource_group.example.location
#   resource_group_name = azurerm_resource_group.example.name


#   default_node_pool {
#     name       = "default"
#     node_count = 1
#     vm_size    = "Standard_D2_v2"
#   }

#   identity {
#     type = "SystemAssigned"
#   }

#   tags = {
#     Environment = "Production"
#   }
# }

