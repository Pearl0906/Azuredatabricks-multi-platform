output "id" {
  description = "Resource ID of the Databricks Access Connector"
  value       = azurerm_databricks_access_connector.this.id
}

output "name" {
  description = "Name of the Databricks Access Connector"
  value       = azurerm_databricks_access_connector.this.name
}

output "principal_id" {
  description = "Principal ID of the Access Connector managed identity"
  value       = azurerm_databricks_access_connector.this.identity[0].principal_id
}

output "tenant_id" {
  description = "Tenant ID of the Access Connector managed identity"
  value       = azurerm_databricks_access_connector.this.identity[0].tenant_id
}