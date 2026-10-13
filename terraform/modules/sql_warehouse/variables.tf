variable "name" {
  description = "Name of the Databricks SQL Warehouse"
  type        = string
}

variable "cluster_size" {
  description = "Size of the SQL Warehouse"
  type        = string

  validation {
    condition = contains(
      [
        "2X-Small",
        "X-Small",
        "Small",
        "Medium",
        "Large",
        "X-Large",
        "2X-Large",
        "3X-Large",
        "4X-Large",
        "5X-Large"
      ],
      var.cluster_size
    )

    error_message = "cluster_size must be a supported Databricks SQL Warehouse size."
  }
}

variable "min_num_clusters" {
  description = "Minimum number of clusters"
  type        = number

  validation {
    condition     = var.min_num_clusters >= 1
    error_message = "min_num_clusters must be at least 1."
  }
}

variable "max_num_clusters" {
  description = "Maximum number of clusters"
  type        = number

  validation {
    condition     = var.max_num_clusters >= var.min_num_clusters
    error_message = "max_num_clusters must be greater than or equal to min_num_clusters."
  }
}

variable "auto_stop_mins" {
  description = "Number of idle minutes before the SQL Warehouse automatically stops"
  type        = number

  validation {
    condition     = var.auto_stop_mins >= 0
    error_message = "auto_stop_mins cannot be negative."
  }
}

variable "enable_photon" {
  description = "Whether Photon is enabled"
  type        = bool
}

variable "enable_serverless_compute" {
  description = "Whether the SQL Warehouse uses serverless compute"
  type        = bool
}

variable "warehouse_type" {
  description = "SQL Warehouse type"
  type        = string

  validation {
    condition     = contains(["PRO", "CLASSIC"], var.warehouse_type)
    error_message = "warehouse_type must be either PRO or CLASSIC."
  }
}

variable "channel_name" {
  description = "Databricks SQL Warehouse release channel"
  type        = string

  validation {
    condition = contains(
      [
        "CHANNEL_NAME_CURRENT",
        "CHANNEL_NAME_PREVIEW"
      ],
      var.channel_name
    )

    error_message = "channel_name must be CHANNEL_NAME_CURRENT or CHANNEL_NAME_PREVIEW."
  }
}

variable "no_wait" {
  description = "Whether Terraform should wait for the warehouse to start"
  type        = bool
}