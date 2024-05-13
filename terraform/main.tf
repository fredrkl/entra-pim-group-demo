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

resource "azuread_group" "pim_group_demo" {
  display_name     = "pim-group-tf-demo-latest"
  security_enabled = true
}

# Starting with azuread group role management policy

resource "azuread_group_role_management_policy" "example" {
  group_id = azuread_group.pim_group_demo.id
  role_id  = "member"
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
      version = "2.49.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "terraform-state-files"
    storage_account_name = "tfaddemostatefiles"
    container_name       = "ad-pim-group-demo-tfstate"
    key                  = "terraform.tfstate"
  }
}
