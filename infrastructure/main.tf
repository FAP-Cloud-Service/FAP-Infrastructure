module "functions" {
  source = "./functions"
  azure_location = var.azure_location
}

module "kubernetes" {
  source = "./kubernetes"
  prod-resource-group-name = module.functions.prod-resource-group-name
  azure_location = var.azure_location
}
