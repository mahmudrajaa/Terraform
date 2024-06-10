output "lb_id" {
  description = "The ID of the created Azure Load Balancer"
  value       = azurerm_lb.example.id
}

output "frontend_ip_configuration" {
  description = "Details of the frontend IP configuration"
  value       = var.frontend_ip_configuration
}