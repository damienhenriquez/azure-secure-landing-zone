output "key_vault_id" {
  description = "Resource ID of the landing zone Key Vault."
  value       = azurerm_key_vault.landing_zone.id
}

output "key_vault_name" {
  description = "Name of the landing zone Key Vault."
  value       = azurerm_key_vault.landing_zone.name
}