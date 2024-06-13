variable "environment" {
    type = string
    default = "dev"
  
}

variable "vnet_purpose" {
  type = string
  default = "Project2vnet"
}

variable "rgpurpose" {
  default = "Tf-Project"
}

variable "rglocation"{
     default = "eastus"
}

variable "IPName"{
type=string
default="TfprojectIP"
}
variable "alloc_method"{
type=string
default="Static"
}

variable "lbname"{
  type=string
default="tfproject_lb"
}

variable "fip_name"{
  type = string
  default = "tfprojectfip"
}

variable backendpoolname {
  type = string
  default="webapppool"
}

variable lbrulename {
  type = string
  default = "lbrule1"
}

variable lbprobename {
  type = string
  default = "lbhealthprobe1"
}