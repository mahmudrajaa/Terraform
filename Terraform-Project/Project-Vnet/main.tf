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

data "terraform_remote_state" "network" {
  backend = "azurerm"
  config = {
    resource_group_name  = "dev-project2-remotestate"
    storage_account_name = "project2remotestate"
    container_name       = "network-terraform-state"
    key                  = "nw-terraform.tfstate"
  }
}

data "azurerm_resource_group" "existing_rg" {
  // name = "dev-Tf-Project-rg"
  name = data.terraform_remote_state.network.outputs.rg_details.rg_details.name
}


locals {
  base_cidr = "10.1.0.0/16"
  subnets = [for i in range(1, 5) : {
    name    = "subnet${i}"
    newbits = 8
    netnum  = i
  }]
}

module "resource-group" {
  source      = "../modules/ResourceGroup"
  rglocation  = var.rglocation
  environment = var.environment
  rgpurpose   = var.rgpurpose
}

module "virtual_network" {
  source        = "../modules/VirtualNetwork"
  address_space = [local.base_cidr]
  rg_name       = data.azurerm_resource_group.existing_rg.name
  location      = data.azurerm_resource_group.existing_rg.location
  subnet-name = {
    for subnet in local.subnets : subnet.name => {
      name    = subnet.name,
      prefix  = cidrsubnet(local.base_cidr, subnet.newbits, subnet.netnum),
      netnum  = subnet.netnum,
      newbits = subnet.newbits
    }
  }
  environment  = var.environment
  vnet_purpose = var.vnet_purpose
}

module "NSG" {
  source   = "../modules/NetworkSecurityGroup"
  rg_name  = data.azurerm_resource_group.existing_rg.name
  location = data.azurerm_resource_group.existing_rg.location

}


