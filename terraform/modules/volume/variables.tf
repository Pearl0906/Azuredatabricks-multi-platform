variable "name" {
  description = "Name of the Unity Catalog volume"
  type        = string
}

variable "catalog_name" {
  description = "Name of the parent Unity Catalog catalog"
  type        = string
}

variable "schema_name" {
  description = "Name of the parent Unity Catalog schema"
  type        = string
}

variable "comment" {
  description = "Description of the Unity Catalog volume"
  type        = string
  default     = ""
}

variable "principal" {
  description = "Databricks user or group that receives access to the volume"
  type        = string
}