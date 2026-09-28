variable "subscription_id" {
  description = "Azure subscription ID used for the landing zone."
  type        = string
}

variable "location" {
  description = "Primary Azure region."
  type        = string
  default     = "eastus"
}

variable "environment" {
  description = "Deployment environment."
  type        = string
  default     = "lab"
}

variable "project_name" {
  description = "Project name used for resource naming."
  type        = string
  default     = "secure-landing-zone"
}

variable "tags" {
  description = "Common resource tags."
  type        = map(string)

  default = {
    ManagedBy   = "Terraform"
    Environment = "Lab"
    Project     = "Secure Azure Landing Zone"
  }
}