data azurerm_storage_account_sas sas {
  connection_string = var.connection_string
  https_only        = true
  start             = "2019-01-01"
  expiry            = "2021-12-31"
  resource_types {
    object    = true
    container = false
    service   = false
  }
  services {
    blob  = true
    queue = false
    table = false
    file  = false
  }
  permissions {
    read    = true
    write   = false
    delete  = false
    list    = false
    add     = false
    create  = false
    update  = false
    process = false
  }
}

resource azurerm_app_service_plan function_asp {
  name                = "${var.name}-plan"
  resource_group_name = var.resource_group
  location            = var.location
  kind                = "FunctionApp"
  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}

resource azurerm_function_app functions {
  name                      = var.name
  location                  = var.location
  resource_group_name       = var.resource_group
  app_service_plan_id       = azurerm_app_service_plan.function_asp.id
  storage_connection_string = var.connection_string
  version                   = "~2"

  app_settings = {
    https_only                   = true
    FUNCTIONS_WORKER_RUNTIME     = "node"
    WEBSITE_NODE_DEFAULT_VERSION = "~10"
    FUNCTION_APP_EDIT_MODE       = "readonly"
    HASH                         = "${base64encode(filesha256("${var.code_source}"))}"
    WEBSITE_RUN_FROM_PACKAGE     = "https://${var.account_name}.blob.core.windows.net/${var.container_name}/${var.blob_name}${data.azurerm_storage_account_sas.sas.sas}"
  }
}