data "azurerm_client_config" "current" {}

locals {
  subscription_suffix = substr(
    replace(var.subscription_id, "-", ""),
    0,
    8
  )

  storage_account_name = "stalztf${local.subscription_suffix}"
}

resource "azurerm_resource_group" "terraform_state" {
  name     = "rg-alz-tfstate"
  location = var.location

  tags = {
    ManagedBy = "Terraform"
    Purpose   = "Terraform Remote State"
    Project   = "Secure Azure Landing Zone"
  }
}

resource "azurerm_storage_account" "terraform_state" {
  name                     = local.storage_account_name
  resource_group_name      = azurerm_resource_group.terraform_state.name
  location                 = azurerm_resource_group.terraform_state.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  min_tls_version                 = "TLS1_2"
  allow_nested_items_to_be_public = false

  blob_properties {
    versioning_enabled = true

    delete_retention_policy {
      days = 7
    }
  }

  tags = {
    ManagedBy = "Terraform"
    Purpose   = "Terraform Remote State"
    Project   = "Secure Azure Landing Zone"
  }
}

resource "azurerm_storage_container" "terraform_state" {
  name                  = "tfstate"
  storage_account_id    = azurerm_storage_account.terraform_state.id
  container_access_type = "private"
}

resource "azurerm_role_assignment" "terraform_state_access" {
  scope                = azurerm_storage_account.terraform_state.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = data.azurerm_client_config.current.object_id
}