terraform {
  backend "azurerm" {
    resource_group_name  = "dev-project2-remotestate"
    storage_account_name = "project2remotestate"
    container_name       = "network-terraform-state"
    key                  = "nw-terraform.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.1.0"
    }
  }
}

provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "existing_rg" {
  name = var.rg_name 
}

locals {
  base_cidr = "10.1.0.0/16"
  subnets = [for i in range(1, 5): {
    name    = "subnet${i}"
    newbits = 8
    netnum  = i
  }]
}

module "virtual_network" {
  source              = "../modules/VirtualNetwork"
  address_space       = [local.base_cidr]
  location            = data.azurerm_resource_group.existing_rg.location
  subnet-name         = { for subnet in local.subnets : subnet.name => { name = subnet.name, prefix = cidrsubnet(local.base_cidr, subnet.newbits, subnet.netnum) } }
  environment         = var.environment
  vnet_purpose        = var.vnet_purpose
}
