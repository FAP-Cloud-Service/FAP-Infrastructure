module "functions" {
  source = "./functions"
  azure_location = var.azure_location
  google_api_key = var.google_api_key
}

module "kubernetes" {
  source = "./kubernetes"
  prod-resource-group-name = module.functions.prod-resource-group-name
  azure_location = var.azure_location
}
