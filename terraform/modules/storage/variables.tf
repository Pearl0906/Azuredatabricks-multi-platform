variable "name" {
  description = "Name of the Azure Storage Account"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
}

variable "location" {
  description = "Azure region where the Storage Account will be created"
  type        = string
}

variable "filesystem_name" {
  description = "Name of the ADLS Gen2 filesystem"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the Storage Account"
  type        = map(string)
  default     = {}
}