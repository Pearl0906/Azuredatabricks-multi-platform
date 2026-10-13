output "id" {
  description = "ID of the Unity Catalog schema"
  value       = databricks_schema.this.id
}

output "name" {
  description = "Name of the Unity Catalog schema"
  value       = databricks_schema.this.name
}

