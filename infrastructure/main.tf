module "functions" {
  source = "./functions"
  azure_location = var.azure_location
  azure_resource_groups = var.azure_resource_groups
}
