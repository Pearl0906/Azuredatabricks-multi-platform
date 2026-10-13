resource "databricks_sql_endpoint" "this" {
  name = var.name

  cluster_size     = var.cluster_size
  min_num_clusters = var.min_num_clusters
  max_num_clusters = var.max_num_clusters

  auto_stop_mins = var.auto_stop_mins

  enable_photon             = var.enable_photon
  enable_serverless_compute = var.enable_serverless_compute

  warehouse_type = var.warehouse_type

  no_wait = var.no_wait

  channel {
    name = var.channel_name
  }

  timeouts {
    create = "30m"
  }
}