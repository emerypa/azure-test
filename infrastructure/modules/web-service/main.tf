resource azurerm_app_service_plan web_service_plan {
  name                = "${var.name}-plan"
  location            = var.location
  resource_group_name = var.resource_group
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource azurerm_app_service web_service {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group
  app_service_plan_id = azurerm_app_service_plan.web_service_plan.id

  site_config {
    app_command_line = ""
    linux_fx_version = "DOCKER|patemery/docker-cra"
  }

  app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
    "DOCKER_REGISTRY_SERVER_URL"          = "https://index.docker.io"
  }
}