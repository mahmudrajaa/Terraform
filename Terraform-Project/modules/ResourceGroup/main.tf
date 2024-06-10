module "naming" {
  source  = "Azure/naming/azurerm"
  version = "0.4.1"
  prefix  = ["${var.environment}", "${var.rgpurpose}"]
}

resource "azurerm_resource_group" "example" {
  name     = module.naming.resource_group.name
  location = var.rglocation

  tags = {
    Environment = var.environment
    Purpose     = var.rgpurpose
  }
}
