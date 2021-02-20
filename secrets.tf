
data "azurerm_key_vault" "kv" {
  name                = "ame-kv01"
  resource_group_name = "mcg-core-svc"
}

data "azurerm_key_vault_secret" "admin_user" {
  name                = "mysql-admin"
  key_vault_id        = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "admin_pwd" {
  name                = "mysql-pwd"
  key_vault_id        = data.azurerm_key_vault.kv.id
}