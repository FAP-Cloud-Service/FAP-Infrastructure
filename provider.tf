terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-backend"
    storage_account_name = "terraformremoteconf"
    container_name       = "prod-terraform-tfstate"
    key                  = "prod.terraform.tfstate"
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.56.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}
