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
  name     = var.rg_name
  location = var.rg_location
}

# App Service
module app_service {
  source      = "./modules/app-service"
  prefix      = var.prefix
  rg_name     = azurerm_resource_group.main.name
  rg_location = azurerm_resource_group.main.location
}

# Database
module database {
  source         = "./modules/database"
  prefix         = var.prefix
  rg_name        = azurerm_resource_group.main.name
  rg_location    = azurerm_resource_group.main.location
  sql_admin_user = var.sql_admin_user
  sql_admin_pass = var.sql_admin_pass
}

# API
module api {
  source      = "./modules/api"
  prefix      = var.prefix
  rg_name     = azurerm_resource_group.main.name
  rg_location = azurerm_resource_group.main.location
}

# Error Logs