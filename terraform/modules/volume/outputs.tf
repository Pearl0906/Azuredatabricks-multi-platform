output "id" {
  description = "Fully qualified ID of the Unity Catalog volume"
  value       = databricks_volume.this.id
}

output "name" {
  description = "Name of the Unity Catalog volume"
  value       = databricks_volume.this.name
}

output "volume_path" {
  description = "Filesystem path to the Unity Catalog volume"
  value       = databricks_volume.this.volume_path
}