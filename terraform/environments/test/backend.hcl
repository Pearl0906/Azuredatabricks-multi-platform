use_cli          = true
use_azuread_auth = true

resource_group_name  = "rg-adp-tfstatetest"
storage_account_name = "stadptfstate03"
container_name       = "tfstate"

key = "azure-data-test.tfstate"