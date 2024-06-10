
# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

locals {
    resource_group_name="dev-project2-remotestate"
    location="East US"
}



resource "azurerm_storage_account" "stroageaccount" {
  name                     = "project2remotestate"
  resource_group_name      = local.resource_group_name
  location                 = local.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "example" {
  name                  = "network-terraform-state"
  storage_account_name  = azurerm_storage_account.stroageaccount.name
  container_access_type = "private"
}

