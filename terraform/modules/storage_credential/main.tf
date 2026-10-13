resource "databricks_storage_credential" "this" {
  name = var.name

  api = "workspace"

  azure_managed_identity {
    access_connector_id = var.access_connector_id
  }

  provider_config {
    workspace_id = var.workspace_id
  }

  comment = var.comment
}