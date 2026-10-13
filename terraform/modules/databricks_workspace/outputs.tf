output "workspace_id" {
  description = "Resource ID of the Databricks workspace"
  value       = azurerm_databricks_workspace.this.id
}

output "workspace_name" {
  description = "Name of the Databricks workspace"
  value       = azurerm_databricks_workspace.this.name
}

output "workspace_url" {
  description = "URL of the Databricks workspace"
  value       = azurerm_databricks_workspace.this.workspace_url
}

output "managed_resource_group_name" {
  description = "Name of the Databricks managed resource group"
  value       = azurerm_databricks_workspace.this.managed_resource_group_name
}

output "databricks_workspace_id" {
  description = "Databricks control-plane workspace ID"
  value       = azurerm_databricks_workspace.this.workspace_id
}

output "resource_id" {
  description = "Azure Resource Manager ID of the Databricks workspace"
  value       = azurerm_databricks_workspace.this.id
}