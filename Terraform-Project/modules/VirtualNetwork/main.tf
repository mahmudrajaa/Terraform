
module "naming" {
  source = "azure/naming/azurerm"
  version = "0.4.1"
  prefix = ["${var.environment}","${var.vnet_purpose}"]
}

resource "azurerm_virtual_network" "vnets" {
  name = module.naming.virtual_network.name
  resource_group_name = var.resourcegroup_name
  location = var.location
  address_space = var.address_space
  tags = {
    Environment = var.environment
    Purpose = var.vnet_purpose

  }
}

resource "azurerm_subnet" "subnets" {
  for_each = var.subnet-name
  name                 = each.key
  address_prefixes     = [cidrsubnet(var.address_space[0], each.value.newbits,each.value.netnum)]
  resource_group_name  = var.resourcegroup_name
  virtual_network_name = azurerm_virtual_network.vnets.name
}