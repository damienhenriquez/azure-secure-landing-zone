variable "subscription_id" {
  description = "Azure subscription used for Terraform state storage."
  type        = string
}

variable "location" {
  description = "Azure region for Terraform state resources."
  type        = string
  default     = "eastus"
}