use_cli          = true
use_azuread_auth = true

resource_group_name  = "rg-adp-tfstate"
storage_account_name = "stadptfstate03"
container_name       = "tfstate"

key = "azure-data-dev.tfstate"