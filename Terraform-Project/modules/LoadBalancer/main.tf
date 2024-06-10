resource "azurerm_lb" "example" {
  name                = var.lbname
  location            = var.location
  resource_group_name = var.rg_name

  frontend_ip_configuration {
    name                 = var.frontend_ip_configuration["example_frontend"]["name"]
    public_ip_address_id = var.frontend_ip_configuration["example_frontend"]["public_ip_address_id"]
  }
  
  tags = var.tags
}