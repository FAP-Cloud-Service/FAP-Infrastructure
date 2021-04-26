module "functions" {
  source         = "./functions"
  azure_tags     = var.azure_tags
  azure_location = var.azure_location
  google_api_key = var.google_api_key
}

module "kubernetes" {
  source = "./kubernetes"
  prod_resource_group = module.functions.prod_resource_group
  azure_location      = var.azure_location
  azure_tags     = var.azure_tags
}

module "secrets" {
  source = "./secrets"
  prod_resource_group    = module.functions.prod_resource_group
  fap_kubernetes_secrets = module.kubernetes.fap_kubernetes_secrets
  azure_tags     = var.azure_tags
}
