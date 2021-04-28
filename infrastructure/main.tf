module "functions" {
  source         = "./functions"
  prod_resource_group = azurerm_resource_group.fap-backend-resource-group
  azure_tags     = var.azure_tags
  azure_location = var.azure_location
  google_api_key = var.google_api_key
}

module "kubernetes" {
  source = "./kubernetes"
  prod_resource_group = azurerm_resource_group.fap-prod-resource-group
  azure_location      = var.azure_location
  azure_tags     = var.azure_tags
}

module "secrets" {
  source = "./secrets"
  prod_resource_group    = azurerm_resource_group.fap-prod-resource-group
  fap_kubernetes_secrets = module.kubernetes.fap_kubernetes_secrets
  azure_tags     = var.azure_tags
}

resource "azurerm_resource_group" "fap-prod-resource-group" {
  name     = "fap-prod-application"
  location = var.azure_location
  tags = var.azure_tags
}
