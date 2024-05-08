# configure the Azur eprovider
terraform{
    required_providers{
        azurerm={
            source="hashicorp/azurerm"
            version="~> 3.0.2"
        }
    }
required_version=">=1.1.0"

}

provider "azurerm"{
    features{

    }
}

resource "azurerm_resource_group" "rgLab5" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_resource_group" "stroageaccount" {
    name=var.resource_group_name
    resource_group_name=azurerm_resource_group.rgLab5.name
    location=azurerm_resource_group.rgLab5.location
    account_tier="Standard"
    account_replication_type="LRS"
    depends_on=[azurerm_resource_group.rgLab5]
    
}