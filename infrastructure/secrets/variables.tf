variable "prod_resource_group" {}
variable "fap_kubernetes_secrets" {}
variable "azure_tags" {}
variable "azure_users" {
  default = [
    "admin@WHS522.onmicrosoft.com"
  ]
}
