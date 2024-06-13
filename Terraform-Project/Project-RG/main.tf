terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.1.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "dev-project2-remotestate"
    storage_account_name = "project2remotestate"
    container_name       = "network-terraform-state"
    key                  = "nw-terraform.tfstate"
  }
}

provider "azurerm" {
  features {
  }
}

module "resource-group" {
  source  = "../modules/ResourceGroup"
  rglocation = var.rglocation
  environment = var.environment
  rgpurpose = var.rgpurpose
}
