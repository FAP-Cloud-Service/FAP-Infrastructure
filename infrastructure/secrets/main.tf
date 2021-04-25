data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "fap-key-vault" {
  name                       = "fap-key-vault"
  location                   = var.prod-resource-group.location
  resource_group_name        = var.prod-resource-group.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  soft_delete_retention_days = 7
  enabled_for_deployment     = true
  tags = {
    tfmanaged = "true"
  }
}

data "azuread_users" "users" {
  user_principal_names = var.azure-user
}

resource "azurerm_key_vault_access_policy" "fap-user-access-policy" {
  key_vault_id = azurerm_key_vault.fap-key-vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  for_each     = toset(data.azuread_users.users.object_ids)
  object_id    = each.value

  key_permissions = [
    "create",
    "get",
  ]

  secret_permissions = [
    "set",
    "get",
    "delete",
    "purge",
    "recover"
  ]
}

resource "azurerm_key_vault_secret" "kubernetes-secret" {
  for_each     = var.fap-kubernetes-secrets
  name         = each.key
  value        = each.value
  key_vault_id = azurerm_key_vault.fap-key-vault.id
  tags = {
    tfmanaged = "true"
  }
}
