module "functions" {
  source = "./functions"
  azure_location = var.azure_location
  google_api_key = var.google_api_key
}
