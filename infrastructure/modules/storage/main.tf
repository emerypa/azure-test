resource random_string storage_name {
  length  = 24
  upper   = false
  lower   = true
  number  = true
  special = false
}

resource azurerm_storage_account main {
  name                     = random_string.storage_name.result
  resource_group_name      = var.resource_group
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource azurerm_storage_container main {
  name                  = "${var.name}-${var.type}-releases"
  storage_account_name  = azurerm_storage_account.main.name
  container_access_type = "private"
}

resource azurerm_storage_blob main {
  name                   = "${var.type}.zip"
  storage_account_name   = azurerm_storage_account.main.name
  storage_container_name = azurerm_storage_container.main.name
  type                   = "Block"
  source                 = var.code_source
}