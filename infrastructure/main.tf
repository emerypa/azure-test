terraform {
  required_version = ">= 0.12"
}

provider "azurerm" {
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
  version         = "=2.0.0"
  features {}
}

# Resource Group
resource azurerm_resource_group main {
  name     = "${var.location}-${var.environment}-${var.name}"
  location = var.location
}

# Web Service
module web_service {
  source         = "./modules/web-service"
  resource_group = azurerm_resource_group.main.name
  location       = azurerm_resource_group.main.location
  name           = "${azurerm_resource_group.main.name}-web-service"
}

# Function Storage
module function_storage {
  source         = "./modules/storage"
  resource_group = azurerm_resource_group.main.name
  location       = azurerm_resource_group.main.location
  name           = "${azurerm_resource_group.main.name}-function-storage"
  type           = "function"
  code_source    = "./build/functionapp.zip"
}

# Function Service
module function_service {
  source            = "./modules/function-service"
  resource_group    = azurerm_resource_group.main.name
  location          = azurerm_resource_group.main.location
  name              = "${azurerm_resource_group.main.name}-function-service"
  connection_string = module.function_storage.connection_string
  account_name      = module.function_storage.account_name
  container_name    = module.function_storage.container_name
  blob_name         = module.function_storage.blob_name
  code_source       = "./build/functionapp.zip"
}

# Database
module database {
  source         = "./modules/database"
  resource_group = azurerm_resource_group.main.name
  location       = azurerm_resource_group.main.location
  name           = "${azurerm_resource_group.main.name}-database"
  sql_admin_user = var.sql_admin_user
  sql_admin_pass = var.sql_admin_pass
}

# Error Logs