module "infrastructure" {
  source         = "./infrastructure"
  azure_location = var.azure_location
  azure_resource_groups = var.azure_resource_groups
}
