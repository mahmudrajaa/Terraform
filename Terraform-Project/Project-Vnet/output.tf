output "rg_details" {
  value = module.resource-group
}

output "vnets" {
 value = module.virtual_network
}

 output "NSG" {
 value = module.NSG
}

output "publicIP"{
  value=module.PublicIP
}

output "lb_details" {
  value=module.LoadBalancer
}