resource "azurerm_storage_account" "this" {
  name                     = var.name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  is_hns_enabled = true

  min_tls_version = "TLS1_2"

  tags = var.tags
}

resource "azurerm_storage_data_lake_gen2_filesystem" "this" {
  name               = var.filesystem_name
  storage_account_id = azurerm_storage_account.this.id
}