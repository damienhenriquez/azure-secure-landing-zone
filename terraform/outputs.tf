output "management_resource_group_name" {
  description = "Name of the management resource group."
  value       = azurerm_resource_group.management.name
}

output "log_analytics_workspace_id" {
  description = "Resource ID of the Log Analytics workspace."
  value       = azurerm_log_analytics_workspace.management.id
}

output "key_vault_name" {
  description = "Name of the landing zone Key Vault."
  value       = module.security.key_vault_name
}