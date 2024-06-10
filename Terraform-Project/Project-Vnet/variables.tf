variable "environment" {
    type = string
    default = "dev"
  
}

variable "vnet_purpose" {
  type = string
  default = "homework2vnet"
}

variable "vnet_name" {
  type=string
  default = "dev-homework2-vnet1"
}
variable "rgname" {
    type=string
  default = "dev-Homework2-rg"
}