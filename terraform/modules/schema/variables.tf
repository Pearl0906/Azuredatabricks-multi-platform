variable "name" {
  description = "Name of the Unity Catalog schema"
  type        = string
}

variable "catalog_name" {
  description = "Name of the Unity Catalog catalog containing the schema"
  type        = string
}

variable "comment" {
  description = "Description of the Unity Catalog schema"
  type        = string
  default     = ""
}

variable "force_destroy" {
  description = "Whether to delete all objects inside the schema when destroying it"
  type        = bool
  default     = false
}

variable "principal" {
  description = "Databricks user or group that receives access to the schema"
  type        = string
}