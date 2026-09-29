terraform {
  backend "azurerm" {
    resource_group_name  = "rg-alz-tfstate"
    storage_account_name = "stalztf68619bcb"
    container_name       = "tfstate"
    key                  = "landing-zone.tfstate"

    use_azuread_auth = true
  }
}