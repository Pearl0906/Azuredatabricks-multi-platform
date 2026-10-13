variable "storage_account_id" {
  description = "Resource ID of the ADLS Gen2 storage account"
  type        = string
}

variable "principal_id" {
  description = "Principal ID of the Databricks Access Connector managed identity"
  type        = string
}