output "role_assignment_id" {
  description = "ID of the storage RBAC role assignment"
  value       = azurerm_role_assignment.storage_blob_data_contributor.id
}