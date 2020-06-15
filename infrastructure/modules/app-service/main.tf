resource azurerm_app_service_plan app_service_plan {
  name                = "${var.prefix}-appserviceplan"
  location            = var.rg_location
  resource_group_name = var.rg_name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource azurerm_app_service app_service {
  name                = "${var.prefix}-appservice"
  location            = var.rg_location
  resource_group_name = var.rg_name
  app_service_plan_id = azurerm_app_service_plan.app_service_plan.id

  site_config {
    app_command_line = ""
    linux_fx_version = "DOCKER|patemery/docker-cra"
  }

  app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
    "DOCKER_REGISTRY_SERVER_URL"          = "https://index.docker.io"
  }
}