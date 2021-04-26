variable "azure_tags" {}
variable "azure_location" {}
variable "google_api_key" {}

variable "azure_resource_group_name" {
  description = "Azure resource group name"
  default     = "friends-and-places"
}

variable "function_zip_path" {
  description = "Path to local zip containing the function"
  default     = "./friends-and-places-server.zip"
}
