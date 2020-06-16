variable resource_group {
  description = "Resource Group Name"
  type        = string
  default     = "test-group"
}

variable location {
  description = "Resource Group Location"
  type        = string
  default     = "eastus"
}

variable name {
  description = "Service Name"
  type        = string
  default     = "test-service"
}