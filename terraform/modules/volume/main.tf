resource "databricks_volume" "this" {
  name         = var.name
  catalog_name = var.catalog_name
  schema_name  = var.schema_name
  volume_type  = "MANAGED"
  comment      = var.comment
}

resource "databricks_grants" "this" {
  volume = databricks_volume.this.id

  grant {
    principal = var.principal
    privileges = [
      "READ_VOLUME",
      "WRITE_VOLUME"
    ]
  }
}