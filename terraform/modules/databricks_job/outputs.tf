output "id" {
  description = "ID of the Databricks Job."
  value       = databricks_job.this.id
}

output "name" {
  description = "Name of the Databricks Job."
  value       = databricks_job.this.name
}

output "job_id" {
  description = "Numeric Databricks Job ID."
  value       = databricks_job.this.id
}

output "url" {
  description = "URL of the Databricks Job."
  value       = databricks_job.this.url
}