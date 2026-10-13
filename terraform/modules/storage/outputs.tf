output "storage_account_name" {
  description = "Name of the Storage Account"
  value       = azurerm_storage_account.this.name
}

output "storage_account_id" {
  description = "Resource ID of the Storage Account"
  value       = azurerm_storage_account.this.id
}

output "filesystem_name" {
  description = "Name of the ADLS Gen2 filesystem"
  value       = azurerm_storage_data_lake_gen2_filesystem.this.name
}

output "primary_dfs_endpoint" {
  description = "Primary DFS endpoint of the ADLS Gen2 Storage Account"
  value       = azurerm_storage_account.this.primary_dfs_endpoint
}