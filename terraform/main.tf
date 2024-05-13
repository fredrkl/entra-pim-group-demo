provider "azurerm" {
  features {}
}

provider "azuread" {
  # Configuration options
}

#resource "azuread_group" "main" {
#  display_name     = "pim-group-demo"
#  owners           = ["ea06710a-7380-4959-9cb8-f8cd0955ac59"]
#  security_enabled = true
#}

resource "azuread_group" "pim_group_demo" {
  display_name     = "pim-group-tf-demo-latest"
  security_enabled = true
}

data "azuread_group" "team_abc" {
  object_id = "5c4f1e8b-2d6e-4c72-abf8-5ab15c32a326"
}
# Starting with azuread group role management policy

resource "azuread_group_role_management_policy" "example" {
  group_id = azuread_group.pim_group_demo.id
  role_id  = "member"

  eligible_assignment_rules {
    expiration_required = false
  }

  activation_rules {
    maximum_duration = "PT1H"
    require_approval = true
    approval_stage {
      primary_approver {
        object_id = "195f7621-c2a1-404f-aa3c-3cf688d8d0b3" # Team ABC Owner
        type      = "groupMembers"
      }
    }
  }
}

resource "azuread_privileged_access_group_eligibility_schedule" "main" {
  group_id             = azuread_group.pim_group_demo.id
  principal_id         = data.azuread_group.team_abc.id
  assignment_type      = "member"
  permanent_assignment = true
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
      version = "2.49.1"
    }
  }

  backend "azurerm" {
    resource_group_name  = "terraform-state-files"
    storage_account_name = "tfaddemostatefiles"
    container_name       = "ad-pim-group-demo-tfstate"
    key                  = "terraform.tfstate"
  }
}
