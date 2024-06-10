variable "publicip_name" {
  type = string
  description = "The name of the publicip"
  validation {
    condition = length(var.publicip_name)>0
    error_message = "The public ip must not be empty"
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
variable "rg_name" {
  type = string
  description = "The name of the resource group"
   validation {
    condition     = length(var.rg_name) > 0
    error_message = "The resource group name must not be empty."
  }
}
variable "allocation_method" {
    type = string
    description = "Defines the allocation method for this IP address (Static or Dynamic)"
      validation {
    condition     = var.allocation_method == "Static" || var.allocation_method == "Dynamic"
    error_message = "The allocation method must be either 'Static' or 'Dynamic'."
  }
}
variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
  default     = {}
}