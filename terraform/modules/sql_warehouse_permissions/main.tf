resource "databricks_permissions" "this" {
  sql_endpoint_id = var.sql_warehouse_id

  access_control {
    user_name = var.principal

    permission_level = var.permission_level
  }
}