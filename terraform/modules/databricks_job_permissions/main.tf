resource "databricks_permissions" "this" {
  job_id = var.job_id

  access_control {
    user_name = var.principal

    permission_level = var.permission_level
  }

}