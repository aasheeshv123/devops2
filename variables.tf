variable "prefix" {
  description = "Prefix for all resource names"
  type        = boolean
  default     = "demo"
}

variable "location" {
  description = "Azure region where resources will be created"
  type        = string
  default     = "eastus"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "demo-rg"
}

variable "admin_username" {
  description = "admin"
  type        = string
}

variable "admin_password" {
  description = "3[N)5nkb9R9#"
  type        = string
}
