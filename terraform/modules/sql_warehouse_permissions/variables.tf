variable "sql_warehouse_id" {
  description = "ID of the Databricks SQL Warehouse"
  type        = string
}

variable "principal" {
  description = "Databricks user or group receiving warehouse access"
  type        = string
}

variable "permission_level" {
  description = "Permission level granted on the SQL Warehouse"
  type        = string

  validation {
    condition = contains(
      [
        "CAN_USE",
        "CAN_MANAGE",
        "CAN_MONITOR"
      ],
      var.permission_level
    )

    error_message = "permission_level must be CAN_USE, CAN_MANAGE, or CAN_MONITOR."
  }
}