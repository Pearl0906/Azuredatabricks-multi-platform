variable "name" {
  description = "Name of the Azure Databricks workspace"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
}

variable "location" {
  description = "Azure region where the Databricks workspace will be created"
  type        = string
}

variable "sku" {
  description = "Databricks workspace SKU"
  type        = string
  default     = "standard"
}

variable "managed_resource_group_name" {
  description = "Name of the Databricks managed resource group"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the Databricks workspace"
  type        = map(string)
  default     = {}
}