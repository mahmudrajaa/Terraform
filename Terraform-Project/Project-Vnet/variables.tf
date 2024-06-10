variable "environment" {
    type = string
    default = "dev"
  
}

variable "vnet_purpose" {
  type = string
  default = "homework2vnet"
}


variable "rg_name" {
    type=string
  default = "dev-Homework2-rg"
}