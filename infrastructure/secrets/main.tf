data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "fap-key-vault" {
  name                       = "fap-key-vault"
  location                   = var.prod_resource_group.location
  resource_group_name        = var.prod_resource_group.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  soft_delete_retention_days = 7
  enabled_for_deployment     = true
  tags                       = var.azure_tags
}

data "azuread_users" "users" {
  user_principal_names = var.azure_users
}

resource "azurerm_key_vault_access_policy" "fap-user-access-policy" {
  key_vault_id = azurerm_key_vault.fap-key-vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  for_each     = toset(concat(data.azuread_users.users.object_ids, [data.azurerm_client_config.current.object_id]))
  object_id    = each.value

  key_permissions = [
    "create",
    "get",
  ]

  secret_permissions = [
    "set",
    "get",
    "Delete",
    "purge",
    "recover",
    "list",
    "Backup",
    "restore"
  ]

  certificate_permissions = [
  "Backup",
  "Create",
  "Delete",
  "DeleteIssuers",
  "Get",
  "GetIssuers",
  "Import",
  "List",
  "ListIssuers",
  "ManageContacts",
  "ManageIssuers",
  "Purge",
  "Recover",
  "Restore",
  "SetIssuers",
  "Update"]
}

resource "azurerm_key_vault_secret" "kubernetes-client-certificate" {
  name         = "kubernetes-client-certificate"
  value        = var.fap_kubernetes_secrets.kubernetes-client-certificate
  key_vault_id = azurerm_key_vault.fap-key-vault.id
  tags = var.azure_tags
}

resource "azurerm_key_vault_secret" "kubernetes-config-raw" {
  name         = "kubernetes-config-raw"
  value        = var.fap_kubernetes_secrets.kubernetes-config-raw
  key_vault_id = azurerm_key_vault.fap-key-vault.id
  tags = var.azure_tags
}
