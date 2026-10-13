resource "databricks_job" "this" {

  email_notifications {
    on_start = var.notify_on_start ? [var.notification_email] : []

    on_success = var.notify_on_success ? [
      var.notification_email
    ] : []

    on_failure = var.notify_on_failure ? [
      var.notification_email
    ] : []

    on_duration_warning_threshold_exceeded = var.notify_on_duration_warning ? [
      var.notification_email
    ] : []
  }
  name        = var.name
  description = var.description

  max_concurrent_runs = var.max_concurrent_runs

  job_cluster {
    job_cluster_key = var.job_cluster_key

    new_cluster {
      spark_version = var.spark_version
      node_type_id  = var.node_type_id
      num_workers   = var.num_workers

      spark_conf = var.spark_conf
    }
  }

  dynamic "task" {
    for_each = var.tasks

    content {
      task_key = task.value.task_key

      job_cluster_key = var.job_cluster_key

      notebook_task {
        notebook_path = task.value.notebook_path

        base_parameters = task.value.base_parameters
      }

      dynamic "depends_on" {
        for_each = task.value.depends_on

        content {
          task_key = depends_on.value
        }
      }

      timeout_seconds = coalesce(
        task.value.timeout_seconds,
        var.timeout_seconds
      )

      max_retries = coalesce(
        task.value.max_retries,
        var.max_retries
      )

      min_retry_interval_millis = coalesce(
        task.value.min_retry_interval_millis,
        var.min_retry_interval_millis
      )

      retry_on_timeout = coalesce(
        task.value.retry_on_timeout,
        var.retry_on_timeout
      )
    }
  }

  dynamic "schedule" {
    for_each = var.schedule_enabled ? [1] : []

    content {
      quartz_cron_expression = var.schedule_quartz_cron_expression
      timezone_id            = var.schedule_timezone_id
      pause_status           = var.pause_status
    }
  }

  tags = var.tags
}