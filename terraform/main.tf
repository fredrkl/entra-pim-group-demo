provider "azurerm" {
  features {}
}

provider "azuread" {
  # Configuration options
}

resource "azuread_group" "main" {
  display_name     = "pim-group-demo"
  owners           = ["ea06710a-7380-4959-9cb8-f8cd0955ac59"]
  security_enabled = true
}

terraform {
  required_version = ">= 1.7"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.85.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.48.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "terraform-state-files"
    storage_account_name = "tfaddemostatefiles"
    container_name       = "ad-pim-group-demo-tfstate"
    key                  = "terraform.tfstate"
  }
}
