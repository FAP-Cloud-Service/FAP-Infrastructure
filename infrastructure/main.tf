module "functions" {
  source         = "./functions"
  azure_tags     = var.azure_tags
  azure_location = var.azure_location
  google_api_key = var.google_api_key
}

module "kubernetes" {
  source = "./kubernetes"
  prod-resource-group = module.functions.prod-resource-group
  azure_location      = var.azure_location
}

module "secrets" {
  source = "./secrets"
  prod-resource-group    = module.functions.prod-resource-group
  fap-kubernetes-secrets = module.kubernetes.fap-kubernetes-secrets
}
