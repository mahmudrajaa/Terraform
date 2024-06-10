variable "vnet-name" {
    type = string
     validation {
    condition     = can(regex("^[a-zA-Z0-9]+(?:-[a-zA-Z0-9]+)*$", var.vnet-name))
    error_message = "The virtual network name must be a non-empty string containing only alphanumeric characters and hyphens, and cannot start or end with a hyphen."
  }
}
variable "resourcegroup_name" {
    type = string
    validation {
      condition = length(var.resourcegroup_name)>0
      error_message = "The resource group must not be empty"
    }
  
}
variable "location" {
    type = string
    validation {
      condition = length(var.location)>0
      error_message = "The location must not be empty"
    }
  
}
variable "address_space" {
  type = list(string)
   validation {
    condition = alltrue([for addr in var.address_space : can(regex("^[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}/[0-9]{1,2}$", addr))])
    error_message = "Each address space must be a valid CIDR notation ."
  }
}

variable "subnet-name" {
    type = map(object({
      name = string
      newbits = number
      netnum = number

    }))
    validation {
    condition = alltrue([
      for k, v in var.subnet-name : 
      (
        can(regex("^.+$", v.name)) &&        
        v.newbits > 0 &&                     
        v.netnum >= 0                       
      )
    ])
    error_message = "Each subnet must have a valid name (non-empty string), newbits (positive number), and netnum (non-negative number)."
  }
}

variable "environment"{
  type = string
  description = "Environment variable value"
}
variable "vnet_purpose"{
  type = string
  description = "vnet_purpose variable value"

}