
variable "name" {
  description = "Globally unique Azure Key Vault name."
  type        = string

  validation {
    condition = (
      length(var.name) >= 3 &&
      length(var.name) <= 24 &&
      can(regex("^[a-zA-Z][a-zA-Z0-9-]*[a-zA-Z0-9]$", var.name))
    )

    error_message = "Key Vault names must be 3-24 characters, start with a letter, and contain only letters, numbers, and hyphens. They must end with a letter or number."
  }
}

variable "resource_group_name" {
  description = "Resource group containing the Key Vault."
  type        = string
}

variable "location" {
  description = "Azure region where the Key Vault will be deployed."
  type        = string
}

variable "tenant_id" {
  description = "Microsoft Entra ID tenant ID."
  type        = string
}

variable "sku_name" {
  description = "Key Vault pricing tier."
  type        = string
  default     = "standard"

  validation {
    condition     = contains(["standard", "premium"], var.sku_name)
    error_message = "sku_name must be standard or premium."
  }
}

variable "soft_delete_retention_days" {
  description = "Number of days deleted vault objects are retained."
  type        = number
  default     = 90

  validation {
    condition = (
      var.soft_delete_retention_days >= 7 &&
      var.soft_delete_retention_days <= 90
    )

    error_message = "Soft-delete retention must be between 7 and 90 days."
  }
}

variable "purge_protection_enabled" {
  description = "Enable protection against permanently purging deleted objects."
  type        = bool
  default     = true
}

variable "public_network_access_enabled" {
  description = "Whether the public network endpoint is enabled."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags applied to the Key Vault."
  type        = map(string)
  default     = {}
}

variable "role_assignments" {
  description = "Optional Azure RBAC assignments scoped to this Key Vault."

  type = list(object({
    principal_object_id  = string
    role_definition_name = string
  }))

  default = []
}
