resource "azurerm_resource_group" "terraform_state" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    Environment = "bootstrap"
    ManagedBy   = "Terraform"
    Purpose     = "Terraform State"
    Project     = "Azure Databricks Data Platform"
  }
}

resource "azurerm_storage_account" "terraform_state" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.terraform_state.name
  location                 = azurerm_resource_group.terraform_state.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  min_tls_version                 = "TLS1_2"
  allow_nested_items_to_be_public = false
  public_network_access_enabled   = true

  blob_properties {
    versioning_enabled = true
  }

  tags = {
    Environment = "bootstrap"
    ManagedBy   = "Terraform"
    Purpose     = "Terraform State"
    Project     = "Azure Databricks Data Platform"
  }
}

resource "azurerm_storage_container" "terraform_state" {
  name                  = var.container_name
  storage_account_id    = azurerm_storage_account.terraform_state.id
  container_access_type = "private"
}

data "azurerm_client_config" "current" {}

resource "azurerm_role_assignment" "tf_state_access" {
  scope                = azurerm_storage_account.terraform_state.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = data.azurerm_client_config.current.object_id
}