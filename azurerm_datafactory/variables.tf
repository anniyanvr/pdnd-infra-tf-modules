# Generic variables

variable "environment" {
  description = "The nick name identifying the type of environment (i.e. test, staging, production)"
}

variable "location" {
  description = "The data center location where all resources will be put into."
}

variable "resource_name_prefix" {
  description = "The prefix used to name all resources created."
}

# Datafactory specific variables

variable "datafactory_name_suffix" {
  description = "The suffix to add to the Data Factory name to distinguish it from others."
}

variable "azurerm_data_factory_github_configuration_account_name" {
  description = "The GitHub account name associated with Data Factory."
}

variable "azurerm_data_factory_github_configuration_branch_name" {
  description = "The GitHub branch name associated with Data Factory. Defaults to the current environment name."
  type        = "string"
  default     = ""
}

variable "azurerm_data_factory_github_configuration_git_url" {
  description = "The GitHub url name associated with Data Factory. Defaults to https://github.com for free accounts. Should be set instead to https://github.{MY_DOMAIN}.com for enterprise accounts."
  default     = "https://github.com"
}

variable "azurerm_data_factory_github_configuration_repository_name" {
  description = "The GitHub repository name associated with Data Factory."
}

variable "azurerm_data_factory_github_configuration_root_folder" {
  description = "The GitHub root folder associated with Data Factory. Default to /"
  default     = "/"
}

locals {
  # Define resource names based on the following convention:
  # {azurerm_resource_name_prefix}-RESOURCE_TYPE-{environment}
  azurerm_resource_group_name                           = "${var.resource_name_prefix}-${var.environment}-rg"
  azurerm_data_factory_name                             = "${var.resource_name_prefix}-${var.environment}-datafactory-${var.datafactory_name_suffix}"
  azurerm_data_factory_github_configuration_branch_name = "${var.azurerm_data_factory_github_configuration_branch_name == "" ? var.environment : var.azurerm_data_factory_github_configuration_branch_name}"
}
