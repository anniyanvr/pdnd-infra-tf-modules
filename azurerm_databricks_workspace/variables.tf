# General Variables

variable "environment" {
  description = "The nick name identifying the type of environment (i.e. test, staging, production)"
}

variable "location" {
  description = "The data center location where all resources will be put into."
}

variable "resource_name_prefix" {
  description = "The prefix used to name all resources created."
}

# Data Bricks variables

variable "azurerm_databricks_workspace_sku" {
  description = "The sku to use for the Databricks Workspace. Possible values are standard or premium."
}
variable "databricks_workspace_name_suffix" {
  description = "The suffix to add to the databricks name to distinguish it from others."
}

locals {
  # Define resource names based on the following convention:
  # {azurerm_resource_name_prefix}-RESOURCE_TYPE-{environment}
  azurerm_resource_group_name                   = "${var.resource_name_prefix}-${var.environment}-rg"
  azurerm_databricks_workspace_name             = "${var.resource_name_prefix}-${var.environment}-databricks-${var.databricks_workspace_name_suffix}"
  azurerm_databricks_workspace_managed_rg_name  = "${var.resource_name_prefix}-${var.environment}-rg-databricks-${var.databricks_workspace_name_suffix}"
}
