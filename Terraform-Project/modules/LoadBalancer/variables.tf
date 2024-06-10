variable "lbname" {
  type = string
  description = "This is the load balancer name."
  validation {
    condition     = length(var.lbname) > 0
    error_message = "The load balancer name must not be empty."
  }
}
variable "rg_name" {
    type = string
    description = "This is the resource group name"
    validation {
    condition     = length(var.rg_name) > 0
    error_message = "The resource group name must not be empty."
  }
  
}
variable "location" {
  type = string
 description = "The location/region where the public IP is created"
     validation {
    condition     = length(var.location) > 0
    error_message = "The location must not be empty."
  }
  }
variable "frontend_ip_configuration" {
  type = map(object({
    name                 = string
    public_ip_address_id = string
  }))
  description = "Configuration for the frontend IP of the load balancer"
  default     = {}

  validation {
    condition     = can(var.frontend_ip_configuration) && length(keys(var.frontend_ip_configuration)) > 0
    error_message = "Frontend IP configuration must be provided and must not be empty."
  }

  validation {
    condition     = alltrue([for k, v in var.frontend_ip_configuration : can(v.name) && length(v.name) > 0])
    error_message = "Each frontend IP configuration 'name' must be provided and must not be empty."
  }

  validation {
    condition     = alltrue([for k, v in var.frontend_ip_configuration : can(v.public_ip_address_id) && length(v.public_ip_address_id) > 0])
    error_message = "Each frontend IP configuration 'public_ip_address_id' must be provided and must not be empty."
  }
}


variable "tags" {
  type = map(string)
  default = {
  }
    description = "A map of tags to assign to the resource"

}