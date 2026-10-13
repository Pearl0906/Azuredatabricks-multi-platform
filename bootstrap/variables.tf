variable "location" {
  description = "Azure region where the Terraform state infrastructure will be created."
  type        = string
  default     = "South Africa North"
}

variable "resource_group_name" {
  description = "Resource group used to host Terraform state storage."
  type        = string
  default     = "rg-adp-tfstate"
}

variable "storage_account_name" {
  description = "Globally unique Azure Storage Account name for Terraform state."
  type        = string
  default     = "stadptfstate03"

  validation {
    condition = (
      length(var.storage_account_name) >= 3 &&
      length(var.storage_account_name) <= 24 &&
      can(regex("^[a-z0-9]+$", var.storage_account_name))
    )

    error_message = "Storage account name must be 3-24 characters and contain only lowercase letters and numbers."
  }
}

variable "container_name" {
  description = "Blob container used to store Terraform state."
  type        = string
  default     = "tfstate"
}