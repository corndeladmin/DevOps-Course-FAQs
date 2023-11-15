terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.8"
    }
  }
  backend "azurerm" {
    resource_group_name  = "Delivery_Management"
    storage_account_name = "academyterraformstate"
    container_name       = "devops-faqs-state"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "main" {
    name = "Delivery_Resources"
}

resource "azurerm_static_site" "example" {
  name                = "devops-faqs-static-web-app"
  resource_group_name = data.azurerm_resource_group.main.name
  location            = "West Europe"
  sku_size = "Standard"
  app_settings = {
    "GITHUB_CLIENT_ID" = var.GITHUB_CLIENT_ID
    "GITHUB_CLIENT_SECRET" = var.GITHUB_CLIENT_SECRET
  }
}