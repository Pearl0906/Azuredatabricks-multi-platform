terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    databricks = {
      source  = "databricks/databricks"
      version = "1.113.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Target the newly created Test workspace explicitly using your root module name
provider "databricks" {
  host                        = "https://${module.databricks_workspace.workspace_url}"
  azure_workspace_resource_id = module.databricks_workspace.resource_id
}
