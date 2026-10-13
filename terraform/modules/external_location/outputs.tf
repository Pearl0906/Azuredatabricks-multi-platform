output "name" {
  description = "Name of the external location"
  value       = databricks_external_location.this.name
}

output "url" {
  description = "URL of the external location"
  value       = databricks_external_location.this.url
}