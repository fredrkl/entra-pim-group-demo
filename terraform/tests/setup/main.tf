provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "resource_group" {
  name     = random_pet.rg.id
  location = "northeurope"
}

resource "random_pet" "rg" {
  length = 1
}

output "resource_group" {
  value = azurerm_resource_group.resource_group
}

terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
  }
}
