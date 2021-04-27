variable "prod_resource_group" {}
variable "fap_kubernetes_secrets" {}
variable "azure_tags" {}
variable "azure_users" {
  default = [
    "Leon.schoenhoffGW_outlook.com#EXT#@friendsandplaces.onmicrosoft.com",
    "maltemorgenstern_gmail.com#EXT#@friendsandplaces.onmicrosoft.com",
    "bjoern.schaefer2_web.de#EXT#@friendsandplaces.onmicrosoft.com",
    "Nick.A.Stelzer_studmail.w-hs.de#EXT#@friendsandplaces.onmicrosoft.com"
  ]
}
