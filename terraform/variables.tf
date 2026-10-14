variable "resource_group_name" {
  description = "Name of the Azure resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "tags" {
  description = "Tags for Azure resources"
  type        = map(string)
  default     = {}
}

variable "storage_account_name" {
  description = "Name of the Azure Storage Account"
  type        = string
}

variable "storage_filesystem_name" {
  description = "Name of the ADLS Gen2 filesystem"
  type        = string
}

variable "access_connector_name" {
  description = "Name of the Databricks Access Connector"
  type        = string
}

variable "databricks_workspace_name" {
  description = "Name of the Azure Databricks workspace"
  type        = string
}

variable "databricks_managed_resource_group_name" {
  description = "Name of the Azure Databricks managed resource group"
  type        = string
}

variable "databricks_sku" {
  description = "Azure Databricks workspace SKU"
  type        = string
  default     = "standard"
}

variable "catalogue_name" {
  description = "Name of the Unity Catalog catalog"
  type        = string
}

variable "catalogue_comment" {
  description = "Description of the Unity Catalog catalog"
  type        = string
  default     = ""
}

variable "catalogue_force_destroy" {
  description = "Whether to delete all objects inside the catalog when destroying it"
  type        = bool
  default     = false
}

variable "external_location_name" {
  description = "Name of the Unity Catalog external location"
  type        = string
}

variable "external_location_comment" {
  description = "Description of the Unity Catalog external location"
  type        = string
  default     = ""
}

variable "storage_credential_name" {
  description = "Name of the Unity Catalog storage credential"
  type        = string
}

variable "storage_credential_comment" {
  description = "Description of the Unity Catalog storage credential"
  type        = string
  default     = ""
}

variable "sql_warehouse_name" {
  description = "Name of the Databricks SQL Warehouse"
  type        = string
}

variable "sql_warehouse_cluster_size" {
  description = "Databricks SQL Warehouse cluster size"
  type        = string
}

variable "sql_warehouse_min_num_clusters" {
  description = "Minimum number of clusters for the SQL Warehouse"
  type        = number
}

variable "sql_warehouse_max_num_clusters" {
  description = "Maximum number of clusters for the SQL Warehouse"
  type        = number
}

variable "sql_warehouse_auto_stop_mins" {
  description = "Idle time in minutes before the SQL Warehouse stops"
  type        = number
}

variable "sql_warehouse_enable_photon" {
  description = "Enable Photon for the SQL Warehouse"
  type        = bool
}

variable "sql_warehouse_enable_serverless_compute" {
  description = "Enable serverless compute"
  type        = bool
}

variable "sql_warehouse_type" {
  description = "SQL Warehouse type"
  type        = string
}

variable "sql_warehouse_channel_name" {
  description = "SQL Warehouse release channel"
  type        = string
}

variable "sql_warehouse_no_wait" {
  description = "Whether Terraform should wait for the warehouse to start"
  type        = bool
}

variable "sql_warehouse_permission_principal" {
  description = "Databricks user or group that receives SQL Warehouse access"
  type        = string
}

variable "sql_warehouse_permission_level" {
  description = "Permission level granted on the SQL Warehouse"
  type        = string

  validation {
    condition = contains(
      [
        "CAN_USE",
        "CAN_MANAGE",
        "CAN_MONITOR"
      ],
      var.sql_warehouse_permission_level
    )

    error_message = "Permission level must be CAN_USE, CAN_MANAGE, or CAN_MONITOR."
  }
}

variable "databricks_job_name" {
  description = "Name of the Databricks data engineering job."
  type        = string
}

variable "databricks_job_description" {
  description = "Description of the Databricks data engineering job."
  type        = string
}

variable "databricks_job_max_concurrent_runs" {
  description = "Maximum number of concurrent job runs."
  type        = number
}

variable "databricks_job_timeout_seconds" {
  description = "Maximum runtime for each task in seconds."
  type        = number
}

variable "databricks_job_max_retries" {
  description = "Maximum number of retries for failed tasks."
  type        = number
}

variable "databricks_job_min_retry_interval_millis" {
  description = "Minimum interval between retries in milliseconds."
  type        = number
}

variable "databricks_job_retry_on_timeout" {
  description = "Whether timed-out tasks should be retried."
  type        = bool
}

variable "databricks_job_schedule_enabled" {
  description = "Whether the Databricks Job schedule is enabled."
  type        = bool
}

variable "databricks_job_schedule_cron" {
  description = "Quartz cron expression for the Databricks Job."
  type        = string
}

variable "databricks_job_schedule_timezone" {
  description = "Timezone used by the Databricks Job schedule."
  type        = string
}

variable "databricks_job_schedule_pause_status" {
  description = "Schedule status: PAUSED or UNPAUSED."
  type        = string
}

variable "databricks_job_cluster_key" {
  description = "Shared job cluster key."
  type        = string
}

variable "databricks_job_spark_version" {
  description = "Databricks Runtime version for the job cluster."
  type        = string
}

variable "databricks_job_node_type_id" {
  description = "Azure VM node type used by the job cluster."
  type        = string
}

variable "databricks_job_num_workers" {
  description = "Number of workers in the job cluster."
  type        = number
}

variable "databricks_job_spark_conf" {
  description = "Spark configuration for the job cluster."
  type        = map(string)
  default     = {}
}

variable "bronze_notebook_path" {
  description = "Workspace path of the Bronze notebook."
  type        = string
}

variable "silver_notebook_path" {
  description = "Workspace path of the Silver notebook."
  type        = string
}

variable "gold_notebook_path" {
  description = "Workspace path of the Gold notebook."
  type        = string
}

variable "databricks_job_permission_principal" {
  description = "Databricks user or group receiving Job permissions."
  type        = string
}

variable "databricks_job_permission_level" {
  description = "Permission level granted on the Databricks Job."
  type        = string

  validation {
    condition = contains(
      [
        "CAN_VIEW",
        "CAN_MANAGE_RUN",
        "CAN_MANAGE"
      ],
      var.databricks_job_permission_level
    )

    error_message = "Job permission level must be CAN_VIEW, CAN_MANAGE_RUN, or CAN_MANAGE."
  }
}

variable "databricks_job_notification_email" {
  description = "Email address that receives Databricks Job notifications."
  type        = string
}

variable "databricks_job_notify_on_start" {
  description = "Whether to notify when the Databricks Job starts."
  type        = bool
  default     = false
}

variable "databricks_job_notify_on_success" {
  description = "Whether to notify when the Databricks Job succeeds."
  type        = bool
  default     = true
}

variable "databricks_job_notify_on_failure" {
  description = "Whether to notify when the Databricks Job fails."
  type        = bool
  default     = true
}

variable "databricks_job_notify_on_duration_warning" {
  description = "Whether to notify when the Databricks Job exceeds its duration warning threshold."
  type        = bool
  default     = false
}

variable "platform_admin_principal" {
  description = "Databricks principal used for platform administration."
  type        = string
}

variable "key_vault_name" {
  description = "Name of the environment's Key Vault."
  type        = string
}

variable "tenant_id" {
  description = "Microsoft Entra ID tenant ID."
  type        = string
}