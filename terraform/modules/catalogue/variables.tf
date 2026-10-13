variable "name" {
  description = "Name of the Unity Catalog catalog"
  type        = string
}

variable "comment" {
  description = "Description of the Unity Catalog catalog"
  type        = string
  default     = ""
}

variable "force_destroy" {
  description = "Whether to delete all objects inside the catalog when destroying it"
  type        = bool
  default     = false
}

variable "storage_root" {
  description = "ADLS Gen2 location used for managed data in the catalog"
  type        = string
}

variable "principal" {
  description = "Databricks user or group that receives access to the catalog"
  type        = string
}