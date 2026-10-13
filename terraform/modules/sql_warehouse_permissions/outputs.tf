output "sql_warehouse_id" {
  description = "SQL Warehouse receiving the permission"
  value       = var.sql_warehouse_id
}

output "principal" {
  description = "User or group receiving the permission"
  value       = var.principal
}

output "permission_level" {
  description = "Permission granted to the principal"
  value       = var.permission_level
}