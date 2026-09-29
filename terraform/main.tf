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