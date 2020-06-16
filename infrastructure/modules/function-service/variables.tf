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

variable connection_string {
  description = "Storage Container Connection String"
  type        = string
  default     = ""
}

variable account_name {
  description = "Storage Account Name"
  type        = string
  default     = ""
}

variable container_name {
  description = "Storage Container Name"
  type        = string
  default     = ""
}

variable blob_name {
  description = "Storage Blob Name"
  type        = string
  default     = ""
}

variable code_source {
  description = "Directory Location of Azure Functions Build Output"
  type        = string
  default     = ""
}