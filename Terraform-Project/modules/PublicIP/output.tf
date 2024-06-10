output "public_ip_address" {
  description = "The allocated public IP address"
  value       = azurerm_public_ip.pubip.ip_address
}

output "public_ip_id" {
  description = "The ID of the public IP"
  value       = azurerm_public_ip.pubip.id
}