output "job_id" {
  description = "Databricks Job receiving the permission."
  value       = var.job_id
}

output "principal" {
  description = "User or group receiving the permission."
  value       = var.principal
}

output "permission_level" {
  description = "Permission granted on the Job."
  value       = var.permission_level
}