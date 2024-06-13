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


resource "azurerm_lb_backend_address_pool" "webapppool" {
  loadbalancer_id = azurerm_lb.example.id
  name            = var.backendpoolname
}

resource "azurerm_lb_rule" "lbrule" {
  loadbalancer_id               = azurerm_lb.example.id
  name                          = var.lbrulename
  protocol                      = "Tcp"
  frontend_port                 = 80
  backend_port                  = 80
  frontend_ip_configuration_name = var.frontend_ip_configuration["example_frontend"]["name"]
}

resource "azurerm_lb_probe" "lbprobe" {
  name                = var.lbprobename
  loadbalancer_id     = azurerm_lb.example.id
  port                = 80
}