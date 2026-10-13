output "id" {
  description = "ID of the Databricks SQL Warehouse"
  value       = databricks_sql_endpoint.this.id
}

output "name" {
  description = "Name of the Databricks SQL Warehouse"
  value       = databricks_sql_endpoint.this.name
}

output "state" {
  description = "Current state of the SQL Warehouse"
  value       = databricks_sql_endpoint.this.state
}

output "jdbc_url" {
  description = "JDBC connection URL for the SQL Warehouse"
  value       = databricks_sql_endpoint.this.jdbc_url
}

output "num_clusters" {
  description = "Number of clusters currently associated with the SQL Warehouse"
  value       = databricks_sql_endpoint.this.num_clusters
}

output "warehouse_type" {
  description = "Type of the SQL Warehouse"
  value       = databricks_sql_endpoint.this.warehouse_type
}