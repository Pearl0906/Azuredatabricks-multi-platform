variable "name" {
  description = "Name of the Unity Catalog external location"
  type        = string
}

variable "url" {
  description = "ADLS Gen2 URL for the external location"
  type        = string
}

variable "credential_name" {
  description = "Name of the Databricks storage credential"
  type        = string
}

variable "comment" {
  description = "Description of the external location"
  type        = string
  default     = ""
}