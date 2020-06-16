output account_name {
  value = azurerm_storage_account.main.name
}

output container_name {
  value = azurerm_storage_container.main.name
}

output blob_name {
  value = azurerm_storage_blob.main.name
}

output connection_string {
  value = azurerm_storage_account.main.primary_connection_string
}