variable "azure_location" {
  description = "Azure hosting location"
  default     = "UK South"
}

variable "google_api_key" {
  type      = string
  sensitive = true
}

variable "azure_tags" {
  type = map(any)
  default = {
    managed_by = "terraform"
  }
}