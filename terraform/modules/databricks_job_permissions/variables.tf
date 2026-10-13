variable "job_id" {
  description = "ID of the Databricks Job receiving the permission."
  type        = string
}

variable "principal" {
  description = "Databricks user or group receiving the Job permission."
  type        = string
}

variable "permission_level" {
  description = "Permission level granted on the Databricks Job."
  type        = string

  validation {
    condition = contains(
      [
        "CAN_VIEW",
        "CAN_MANAGE_RUN",
        "CAN_MANAGE"
      ],
      var.permission_level
    )

    error_message = "permission_level must be CAN_VIEW, CAN_MANAGE_RUN, or CAN_MANAGE."
  }
}

