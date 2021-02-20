resource "azurerm_resource_group" "demo_app" {
  name              = "azsat-demo-app"
  location          = "westus2"
}

resource "azurerm_mysql_server" "demo_db" {
  name                = "azsat-db"
  location            = azurerm_resource_group.demo_app.location
  resource_group_name = azurerm_resource_group.demo_app.name

  administrator_login          = data.azurerm_key_vault_secret.admin_user.value
  administrator_login_password = data.azurerm_key_vault_secret.admin_pwd.value

  sku_name   = "B_Gen5_4"
  storage_mb = 5120
  version    = "5.7"

  auto_grow_enabled                 = true
  backup_retention_days             = 7
  geo_redundant_backup_enabled      = false
  infrastructure_encryption_enabled = false
  public_network_access_enabled     = true
  ssl_enforcement_enabled           = true
  ssl_minimal_tls_version_enforced  = "TLS1_2"
}

resource "azurerm_mysql_database" "app_users" {
  name                = "users"
  resource_group_name = azurerm_resource_group.demo_app.name
  server_name         = azurerm_mysql_server.demo_db.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}
