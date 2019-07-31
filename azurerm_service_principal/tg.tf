provider "azurerm" {
  version = "~>1.32"
}

provider "azuread" {
  version = "~>0.2"
}

terraform {
  backend "azurerm" {}
}
