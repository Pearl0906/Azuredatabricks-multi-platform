variable "name" {
  description = "Name of the Databricks Access Connector"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
}

variable "location" {
  description = "Azure region where the Access Connector will be created"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the Access Connector"
  type        = map(string)
  default     = {}
}