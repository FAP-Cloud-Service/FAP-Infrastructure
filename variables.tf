variable "azure_location" {
  description = "Azure hosting location"
  default     = "UK South"
}

variable "google_api_key" {
  type      = string
  sensitive = true
}