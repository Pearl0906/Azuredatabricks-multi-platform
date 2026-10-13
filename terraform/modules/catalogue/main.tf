resource "databricks_catalog" "this" {
  name          = var.name
  comment       = var.comment
  force_destroy = var.force_destroy
  storage_root  = var.storage_root
}

resource "databricks_grants" "this" {
  catalog = databricks_catalog.this.name

  grant {
    principal  = var.principal
    privileges = ["BROWSE", "USE_CATALOG"]
  }
}