resource "databricks_schema" "this" {
  name          = var.name
  catalog_name  = var.catalog_name
  comment       = var.comment
  force_destroy = var.force_destroy
}

resource "databricks_grants" "this" {
  schema = databricks_schema.this.id

  grant {
    principal  = var.principal
    privileges = ["USE_SCHEMA"]
  }
}

