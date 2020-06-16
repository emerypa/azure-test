
resource azurerm_sql_server main {
  name                         = "${var.name}-sql-server"
  resource_group_name          = var.resource_group
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.sql_admin_user
  administrator_login_password = var.sql_admin_pass
}

resource azurerm_sql_database main {
  name                             = var.name
  resource_group_name              = var.resource_group
  location                         = var.location
  server_name                      = azurerm_sql_server.main.name
  edition                          = "Basic"
  collation                        = "SQL_Latin1_General_CP1_CI_AS"
  create_mode                      = "Default"
  requested_service_objective_name = "Basic"
}

# Enables the "Allow Access to Azure services" box as described in the API docs
# https://docs.microsoft.com/en-us/rest/api/sql/firewallrules/createorupdate
resource azurerm_sql_firewall_rule main {
  name                = "allow-azure-services"
  resource_group_name = var.resource_group
  server_name         = azurerm_sql_server.main.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}