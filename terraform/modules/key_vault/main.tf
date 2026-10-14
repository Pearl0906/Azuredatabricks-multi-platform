
resource "azurerm_key_vault" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = var.tenant_id
  sku_name            = var.sku_name

  # Use Azure Role-Based Access Control (RBAC)
  rbac_authorization_enabled = true

  # Protect secrets from accidental deletion
  soft_delete_retention_days = var.soft_delete_retention_days
  purge_protection_enabled   = var.purge_protection_enabled

  # Allow public endpoint access initially.
  # Restrict networking when private endpoints are implemented.
  public_network_access_enabled = var.public_network_access_enabled

  tags = var.tags
}

# Grant access to explicitly supplied principals.
# The module creates no permissions unless assignments are supplied.
resource "azurerm_role_assignment" "this" {
  for_each = {
    for assignment in var.role_assignments :
    "${assignment.principal_object_id}-${assignment.role_definition_name}" => assignment
  }

  scope                = azurerm_key_vault.this.id
  role_definition_name = each.value.role_definition_name
  principal_id         = each.value.principal_object_id
}
