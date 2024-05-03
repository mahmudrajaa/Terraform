#configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0.2"
    }
  }
  required_version = ">= 1.1.0"
}
provider "azurerm" {
  features {}
}
resource "azurerm_resource_group" "rg" {
  name     = "Raja-Terraform-Resource-1"
  location = "southeast asia"
}

resource "azurerm_resource_group" "rgnew" {
  name     = "Raja-Terraform-Resource-2"
  location = "southeast asia"
}
