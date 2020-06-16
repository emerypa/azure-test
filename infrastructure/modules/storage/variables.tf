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

variable type {
  description = "Storage Account Type"
  type        = string
  default     = "test"
}

variable code_source {
  description = "Directory Location of Azure Functions Build Output"
  type        = string
  default     = "./build/functionapp.zip"
}