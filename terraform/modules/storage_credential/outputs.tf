output "id" {
  description = "ID of the Unity Catalog storage credential"
  value       = databricks_storage_credential.this.id
}

output "name" {
  description = "Name of the Unity Catalog storage credential"
  value       = databricks_storage_credential.this.name
}

output "workspace_id_debug" {
  value = var.workspace_id
}