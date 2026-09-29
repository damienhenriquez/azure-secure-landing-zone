data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "landing_zone" {
  name = "kv-alz-${var.environment}-${substr(
    replace(var.subscription_id, "-", ""),
    0,
    8
  )}"

  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"

  rbac_authorization_enabled    = true
  public_network_access_enabled = false

  soft_delete_retention_days = 7
  purge_protection_enabled   = false

  tags = var.tags
}

resource "azurerm_role_assignment" "key_vault_secrets_officer" {
  scope                = azurerm_key_vault.landing_zone.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "azurerm_monitor_diagnostic_setting" "key_vault" {
  name                       = "diag-key-vault-to-log-analytics"
  target_resource_id         = azurerm_key_vault.landing_zone.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  enabled_log {
    category = "AuditEvent"
  }
}

resource "azurerm_policy_definition" "environment_tag" {
  name         = "audit-required-environment-tag"
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = "Audit resources missing the Environment tag"

  policy_rule = jsonencode({
    "if" = {
      "field"  = "tags['Environment']"
      "exists" = "false"
    }

    "then" = {
      "effect" = "audit"
    }
  })
}

resource "azurerm_resource_group_policy_assignment" "environment_tag" {
  name                 = "audit-environment-tag"
  resource_group_id    = var.resource_group_id
  policy_definition_id = azurerm_policy_definition.environment_tag.id
  display_name         = "Audit resources missing Environment tag"
  description          = "Identifies resources that do not contain the required Environment tag."
}