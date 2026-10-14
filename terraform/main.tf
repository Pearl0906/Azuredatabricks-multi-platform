module "resource_group" {
  source = "./modules/resource_group"

  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

module "storage" {
  source = "./modules/storage"

  name                = var.storage_account_name
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  filesystem_name     = var.storage_filesystem_name
  tags                = var.tags
}

module "access_connector" {
  source = "./modules/access_connector"

  name                = var.access_connector_name
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  tags                = var.tags
}

module "storage_access" {
  source = "./modules/storage_access"

  storage_account_id = module.storage.storage_account_id
  principal_id       = module.access_connector.principal_id
}

module "databricks_workspace" {
  source = "./modules/databricks_workspace"

  name                        = var.databricks_workspace_name
  resource_group_name         = module.resource_group.name
  location                    = module.resource_group.location
  sku                         = var.databricks_sku
  managed_resource_group_name = var.databricks_managed_resource_group_name
  tags                        = var.tags
}

module "catalogue" {
  source = "./modules/catalogue"

  name          = var.catalogue_name
  comment       = var.catalogue_comment
  force_destroy = var.catalogue_force_destroy

  storage_root = module.external_location.url

  principal = var.platform_admin_principal
}

module "external_location" {
  source = "./modules/external_location"

  name            = var.external_location_name
  url             = "abfss://${module.storage.filesystem_name}@${trimsuffix(replace(module.storage.primary_dfs_endpoint, "https://", ""), "/")}/data-platform"
  credential_name = module.storage_credential.name
  comment         = var.external_location_comment
}

module "storage_credential" {
  source = "./modules/storage_credential"

  name                = var.storage_credential_name
  access_connector_id = module.access_connector.id
  workspace_id        = module.databricks_workspace.databricks_workspace_id
  comment             = var.storage_credential_comment
}

module "bronze_schema" {
  source = "./modules/schema"

  name          = "bronze"
  catalog_name  = module.catalogue.catalog_name
  comment       = "Bronze layer containing raw ingested data"
  force_destroy = false
  principal     = var.platform_admin_principal
}

module "raw_volume" {
  source = "./modules/volume"

  name         = "raw"
  catalog_name = module.catalogue.catalog_name
  schema_name  = module.bronze_schema.name
  comment      = "Raw data volume for the Bronze layer"
  principal    = var.platform_admin_principal
}

module "silver_schema" {
  source = "./modules/schema"

  name          = "silver"
  catalog_name  = module.catalogue.catalog_name
  comment       = "Silver layer containing cleaned and transformed data"
  force_destroy = false
  principal     = var.platform_admin_principal
}

module "gold_schema" {
  source = "./modules/schema"

  name          = "gold"
  catalog_name  = module.catalogue.catalog_name
  comment       = "Gold layer containing business-ready data"
  force_destroy = false
  principal     = var.platform_admin_principal
}

module "sql_warehouse" {
  source = "./modules/sql_warehouse"

  name = var.sql_warehouse_name

  cluster_size     = var.sql_warehouse_cluster_size
  min_num_clusters = var.sql_warehouse_min_num_clusters
  max_num_clusters = var.sql_warehouse_max_num_clusters

  auto_stop_mins = var.sql_warehouse_auto_stop_mins

  enable_photon             = var.sql_warehouse_enable_photon
  enable_serverless_compute = var.sql_warehouse_enable_serverless_compute

  warehouse_type = var.sql_warehouse_type
  channel_name   = var.sql_warehouse_channel_name

  no_wait = var.sql_warehouse_no_wait
}

module "databricks_job" {
  source = "./modules/databricks_job"

  name        = var.databricks_job_name
  description = var.databricks_job_description

  max_concurrent_runs = var.databricks_job_max_concurrent_runs

  notification_email = var.databricks_job_notification_email

  notify_on_start            = var.databricks_job_notify_on_start
  notify_on_success          = var.databricks_job_notify_on_success
  notify_on_failure          = var.databricks_job_notify_on_failure
  notify_on_duration_warning = var.databricks_job_notify_on_duration_warning

  timeout_seconds           = var.databricks_job_timeout_seconds
  max_retries               = var.databricks_job_max_retries
  min_retry_interval_millis = var.databricks_job_min_retry_interval_millis
  retry_on_timeout          = var.databricks_job_retry_on_timeout

  schedule_enabled                = var.databricks_job_schedule_enabled
  schedule_quartz_cron_expression = var.databricks_job_schedule_cron
  schedule_timezone_id            = var.databricks_job_schedule_timezone
  pause_status                    = var.databricks_job_schedule_pause_status

  job_cluster_key = var.databricks_job_cluster_key
  spark_version   = var.databricks_job_spark_version
  node_type_id    = var.databricks_job_node_type_id
  num_workers     = var.databricks_job_num_workers

  spark_conf = var.databricks_job_spark_conf

  tags = var.tags

  tasks = [
   {
      task_key      = "bronze"
      notebook_path = var.bronze_notebook_path
    },
   {
      task_key      = "gold"
     notebook_path = var.gold_notebook_path
      depends_on    = ["silver"]
    },
    {
      task_key      = "silver"
     notebook_path = var.silver_notebook_path
      depends_on    = ["bronze"]
   }
  ]
}

module "databricks_job_permissions" {
  source = "./modules/databricks_job_permissions"

  job_id           = module.databricks_job.id
  principal        = var.databricks_job_permission_principal
  permission_level = var.databricks_job_permission_level

}


module "key_vault" {
  source = "./modules/key_vault"

  name                = var.key_vault_name
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  tenant_id           = var.tenant_id

  sku_name                   = "standard"
  soft_delete_retention_days = 90
  purge_protection_enabled   = true

  tags = var.tags
}
