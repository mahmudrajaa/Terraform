resource "azurerm_public_ip" "pubip" {
  name = var.publicip_name
  resource_group_name = var.rg_name
  location = var.location
  allocation_method = var.allocation_method
  tags = var.tags
}