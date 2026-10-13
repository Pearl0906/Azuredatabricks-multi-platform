output "access_connector_id" {
  description = "Databricks Access Connector resource ID"
  value       = module.access_connector.id
}

output "access_connector_principal_id" {
  description = "Managed identity principal ID used by Unity Catalog"
  value       = module.access_connector.principal_id
}

output "sql_warehouse_id" {
  description = "ID of the Databricks SQL Warehouse"
  value       = module.sql_warehouse.id
}

output "sql_warehouse_name" {
  description = "Name of the Databricks SQL Warehouse"
  value       = module.sql_warehouse.name
}

output "sql_warehouse_state" {
  description = "Current state of the Databricks SQL Warehouse"
  value       = module.sql_warehouse.state
}

output "sql_warehouse_jdbc_url" {
  description = "JDBC URL of the Databricks SQL Warehouse"
  value       = module.sql_warehouse.jdbc_url
}

output "sql_warehouse_num_clusters" {
  description = "Number of clusters currently associated with the SQL Warehouse"
  value       = module.sql_warehouse.num_clusters
}

output "sql_warehouse_type" {
  description = "Type of the Databricks SQL Warehouse"
  value       = module.sql_warehouse.warehouse_type
}

output "databricks_job_id" {
  description = "ID of the Databricks data engineering Job."
  value       = module.databricks_job.id
}

output "databricks_job_name" {
  description = "Name of the Databricks data engineering Job."
  value       = module.databricks_job.name
}

output "databricks_job_url" {
  description = "URL of the Databricks data engineering Job."
  value       = module.databricks_job.url
}

output "databricks_job_permission_principal" {
  description = "Principal receiving Databricks Job permissions."
  value       = module.databricks_job_permissions.principal
}

output "databricks_job_permission_level" {
  description = "Permission level granted on the Databricks Job."
  value       = module.databricks_job_permissions.permission_level
}