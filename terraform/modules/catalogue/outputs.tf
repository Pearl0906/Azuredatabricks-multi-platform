output "catalog_name" {
  description = "Name of the Unity Catalog catalog"
  value       = databricks_catalog.this.name
}