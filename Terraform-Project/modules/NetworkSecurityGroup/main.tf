data "terraform_remote_state" "network" {
  backend = "azurerm"
  config = {
   resource_group_name  = "dev-project2-remotestate"
    storage_account_name = "project2remotestate"
    container_name       = "network-terraform-state"
    key                  = "nw-terraform.tfstate"
  }
}

locals {
  vnets   = data.terraform_remote_state.network.outputs.vnets
  subnets = data.terraform_remote_state.network.outputs.subnets
}

locals {
  flat_subnets = flatten([
    for vnet, details in local.vnets : [
      for subnet in local.subnets : {
        vnet_name   = vnet
        subnet_name = subnet.name
        newbits     = subnet.newbits
        netnum      = subnet.netnum
      }
    ]
  ])
}


locals {
  rules_csv = try(csvdecode(file(var.rules_file)), [])
  nsg_name = { for subnet in local.flat_subnets : "${subnet.vnet_name}-${subnet.subnet_name}" => {
    name = "${subnet.vnet_name}-${subnet.subnet_name}"
  } }
}

data "azurerm_resource_group" "existing_rg" {
  name = var.resource_group_name 
}

resource "azurerm_network_security_group" "this" {
  for_each = local.nsg_name

  name                = each.value.name
   resource_group_name = data.azurerm_resource_group.existing_rg.name
  location            = data.azurerm_resource_group.existing_rg.location
 

  dynamic "security_rule" {
    for_each = { for rule in local.rules_csv : rule.name => rule }
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }
}

resource "azurerm_subnet_network_security_group_association" "this" {
  for_each = local.nsg_name

  subnet_id                 = azurerm_subnet.subnet[each.key].id
  network_security_group_id = azurerm_network_security_group.this[each.key].id

  depends_on = [
    azurerm_subnet.subnet,
    azurerm_network_security_group.this
  ]
}