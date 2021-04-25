variable "prod-resource-group" {}
variable "fap-kubernetes-secrets" {}
variable "azure-user" {
  default = [
    "Leon.schoenhoffGW_outlook.com#EXT#@friendsandplaces.onmicrosoft.com",
    "maltemorgenstern_gmail.com#EXT#@friendsandplaces.onmicrosoft.com",
    "bjoern.schaefer2_web.de#EXT#@friendsandplaces.onmicrosoft.com",
    "Nick.A.Stelzer_studmail.w-hs.de#EXT#@friendsandplaces.onmicrosoft.com"
  ]
}
