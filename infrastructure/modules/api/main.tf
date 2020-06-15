resource azurerm_api_management main {
  name                = "${var.prefix}-apim"
  location            = var.rg_location
  resource_group_name = var.rg_name
  publisher_name      = "My Company"
  publisher_email     = "company@terraform.io"

  sku_name = "Developer_1"
}

resource azurerm_api_management_api main {
  name                = "${var.prefix}-api"
  resource_group_name = var.rg_name
  api_management_name = azurerm_api_management.main.name
  revision            = "1"
  display_name        = "${var.prefix} API"
  path                = "v1"
  protocols           = ["https"]

  import {
    content_format = "swagger-json"
    content_value  = file("${path.module}/templates/api.json")
  }
}