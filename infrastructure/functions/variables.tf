variable "azure_tags" {}
variable "azure_location" {}
variable "google_api_key" {}
variable "prod_resource_group" {}

variable "function_zip_path" {
  description = "Path to local zip containing the function"
  default     = "./friends-and-places-server.zip"
}
