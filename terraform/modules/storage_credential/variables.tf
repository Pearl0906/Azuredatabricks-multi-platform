variable "name" {
  description = "Name of the Unity Catalog storage credential"
  type        = string
}

variable "access_connector_id" {
  description = "Resource ID of the Azure Databricks Access Connector"
  type        = string
}

variable "comment" {
  description = "Description of the storage credential"
  type        = string
  default     = ""
}

variable "workspace_id" {
  description = "Databricks workspace ID that owns the storage credential"
  type        = string
}