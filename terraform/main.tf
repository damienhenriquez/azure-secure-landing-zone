locals {
  prefix = "alz-${var.environment}"
}

resource "azurerm_resource_group" "management" {
  name     = "rg-${local.prefix}-management"
  location = var.location

  tags = var.tags
}

resource "azurerm_log_analytics_workspace" "management" {
  name                = "law-${local.prefix}-management"
  location            = azurerm_resource_group.management.location
  resource_group_name = azurerm_resource_group.management.name

  sku               = "PerGB2018"
  retention_in_days = 30

  tags = var.tags
}

module "networking" {
  source = "../modules/networking"

  resource_group_name = azurerm_resource_group.management.name
  location            = var.location
  tags                = var.tags
}

module "security" {
  source = "../modules/security"

  resource_group_name          = azurerm_resource_group.management.name
  resource_group_id            = azurerm_resource_group.management.id
  location                     = var.location
  subscription_id              = var.subscription_id
  environment                  = var.environment
  key_vault_admin_principal_id = var.key_vault_admin_principal_id
  log_analytics_workspace_id   = azurerm_log_analytics_workspace.management.id
  tags                         = var.tags
}