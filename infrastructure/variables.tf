variable tenant_id {}
variable subscription_id {}
variable sql_admin_user {}
variable sql_admin_pass {}

variable location {
  description = "Resource Group Location"
  type        = string
  default     = "eastus"
}

variable environment {
  description = "dev/stage/prod"
  type        = string
  default     = "dev"
}

variable name {
  description = ""
  type        = string
  default     = "azure-app"
}