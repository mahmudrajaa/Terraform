
variable "rg_name" {
    type = string
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