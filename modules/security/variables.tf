variable "resource_group_name" {
  description = "Name of the landing zone management resource group."
  type        = string
}

variable "resource_group_id" {
  description = "Resource ID of the landing zone management resource group."
  type        = string
}

variable "location" {
  description = "Azure region for security resources."
  type        = string
}

variable "subscription_id" {
  description = "Azure subscription ID."
  type        = string
}

variable "environment" {
  description = "Deployment environment."
  type        = string
}

variable "log_analytics_workspace_id" {
  description = "Resource ID of the centralized Log Analytics workspace."
  type        = string
}

variable "tags" {
  description = "Common resource tags."
  type        = map(string)
}

variable "key_vault_admin_principal_id" {
  description = "Entra object ID granted Key Vault Secrets Officer."
  type        = string
}