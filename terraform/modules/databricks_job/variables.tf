variable "name" {
  description = "Name of the Databricks Job."
  type        = string
}

variable "description" {
  description = "Description of the Databricks Job."
  type        = string
  default     = "Managed by Terraform."
}

variable "max_concurrent_runs" {
  description = "Maximum number of concurrent runs allowed for the job."
  type        = number
  default     = 1

  validation {
    condition     = var.max_concurrent_runs >= 1
    error_message = "max_concurrent_runs must be at least 1."
  }
}

variable "timeout_seconds" {
  description = "Maximum runtime for each task in seconds."
  type        = number
  default     = 3600

  validation {
    condition     = var.timeout_seconds > 0
    error_message = "timeout_seconds must be greater than 0."
  }
}

variable "max_retries" {
  description = "Maximum number of retries for a failed task."
  type        = number
  default     = 2

  validation {
    condition     = var.max_retries >= 0
    error_message = "max_retries must be zero or greater."
  }
}

variable "min_retry_interval_millis" {
  description = "Minimum time between task retries in milliseconds."
  type        = number
  default     = 30000

  validation {
    condition     = var.min_retry_interval_millis >= 0
    error_message = "min_retry_interval_millis must be zero or greater."
  }
}

variable "retry_on_timeout" {
  description = "Whether a timed-out task should be retried."
  type        = bool
  default     = true
}

variable "pause_status" {
  description = "Schedule pause status. Use PAUSED or UNPAUSED."
  type        = string
  default     = "PAUSED"

  validation {
    condition = contains(
      [
        "PAUSED",
        "UNPAUSED"
      ],
      var.pause_status
    )

    error_message = "pause_status must be PAUSED or UNPAUSED."
  }
}

variable "schedule_quartz_cron_expression" {
  description = "Quartz cron expression for the job schedule."
  type        = string
  default     = "0 0 2 * * ?"
}

variable "schedule_timezone_id" {
  description = "Timezone used by the Databricks Job schedule."
  type        = string
  default     = "Africa/Johannesburg"
}

variable "schedule_enabled" {
  description = "Whether a schedule should be configured for the job."
  type        = bool
  default     = false
}

variable "job_cluster_key" {
  description = "Name of the shared job cluster."
  type        = string
  default     = "data-platform-job-cluster"
}

variable "spark_version" {
  description = "Databricks Runtime version used by the job cluster."
  type        = string
  default     = "latest"
}

variable "node_type_id" {
  description = "Azure VM node type used by the job cluster."
  type        = string
  default     = "Standard_DS3_v2"
}

variable "num_workers" {
  description = "Number of workers used by the job cluster."
  type        = number
  default     = 1

  validation {
    condition     = var.num_workers >= 1
    error_message = "num_workers must be at least 1."
  }
}

variable "spark_conf" {
  description = "Optional Spark configuration for the job cluster."
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "Tags applied to the Databricks Job."
  type        = map(string)
  default     = {}
}

variable "tasks" {
  description = "Tasks executed by the Databricks Job."
  type = list(object({
    task_key = string

    notebook_path = string

    depends_on = optional(list(string), [])

    base_parameters = optional(map(string), {})

    timeout_seconds           = optional(number)
    max_retries               = optional(number)
    min_retry_interval_millis = optional(number)
    retry_on_timeout          = optional(bool)
  }))

  default = []
}

variable "notification_email" {
  description = "Email address that receives Databricks Job notifications."
  type        = string
}

variable "notify_on_start" {
  description = "Whether to send an email when the Job starts."
  type        = bool
  default     = false
}

variable "notify_on_success" {
  description = "Whether to send an email when the Job succeeds."
  type        = bool
  default     = true
}

variable "notify_on_failure" {
  description = "Whether to send an email when the Job fails."
  type        = bool
  default     = true
}

variable "notify_on_duration_warning" {
  description = "Whether to send an email when the Job exceeds its duration warning threshold."
  type        = bool
  default     = false
}