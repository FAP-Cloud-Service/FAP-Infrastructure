module "infrastructure" {
  source         = "./infrastructure"
  azure_tags     = var.azure_tags
  azure_location = var.azure_location
  google_api_key = var.google_api_key
}
