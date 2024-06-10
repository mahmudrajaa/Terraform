variable "rules_file" {
  description = "The path to the CSV file containing the rules"
  type        = string
  default     = "rules.csv"
}


variable "location" {
  description = "The location of the resources"
  type        = string
}

variable "resource_group_name" {
    description = "The existing resource group name"
  type        = string
}
