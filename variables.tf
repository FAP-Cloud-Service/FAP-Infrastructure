variable "azure_location" {
  description = "Azure hosting location"
  default     = "UK South"
}

variable "azure_resource_groups" {
  description = "Array of names for azure-resource-Group"
  default = ["fap-service-prod"]
}
