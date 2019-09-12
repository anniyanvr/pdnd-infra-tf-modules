# General variables

variable "environment" {
  description = "The nick name identifying the type of environment (i.e. test, staging, production)."
}

variable "resource_name_prefix" {
  description = "The prefix used to name all resources created."
}

variable "location" {
  description = "The data center location where all resources will be put into."
}

variable "vnet_name" {
  description = "The name suffix of the virtual network where nodes and external load balancers' IPs will be created."
}

variable "subnet_name" {
  description = "The name of the virtual network connecting all resources."
}

# Container group specific variables

variable "azurerm_container_group_name_suffix" {
  description = "Specifies the suffix name of the Container Group. Changing this forces a new resource to be created."
}

variable "azurerm_container_group_ip_address_type" {
  description = " Specifies the ip address type of the container. public or private."
}

variable "azurerm_container_group_container_image" {
  description = "The container image name. Changing this forces a new resource to be created."
}

variable "azurerm_container_group_container_cpu" {
  description = "The required number of CPU cores of the containers. Changing this forces a new resource to be created."
}

variable "azurerm_container_group_container_memory" {
  description = "The required memory of the containers in GB. Changing this forces a new resource to be created."
}

variable "azurerm_container_group_container_port" {
  description = "A set of public ports for the container. Changing this forces a new resource to be created."
}

variable "azurerm_container_group_container_sftp_user" {
  description = "Env variable, that contains the main user."
}

variable "azurerm_container_group_container_sftp_env_users" {
  description = "Env variable, that contains the users to created."
}

variable "storage_account_name" {
  description = "The suffix used to identify the specific Azure storage account"
}

variable "storage_account_share_name_suffix" {
  description = "The name of the share."
}

variable "azurerm_azuread_service_principal_name" {
  description = "The Display Name of the Azure AD Application associated with this Service Principal."
}

variable "log_analytics_workspace_name" {
  description = "The name of the log analytics workspace. It will be used as the logs analytics workspace name suffix."
}

locals {
  # Define resource names based on the following convention (if allowed by Azure):
  # {azurerm_resource_name_prefix}-RESOURCE_TYPE-{environment}
  azurerm_resource_group_name                     = "${var.resource_name_prefix}-${var.environment}-rg"
  azurerm_virtual_network_name                    = "${var.resource_name_prefix}-${var.environment}-vnet-${var.vnet_name}"
  azurerm_subnet_name                             = "${var.resource_name_prefix}-${var.environment}-subnet-${var.subnet_name}"
  azurerm_network_profile_name                    = "${var.resource_name_prefix}-${var.environment}-subnet-${var.subnet_name}"
  azurerm_container_group_name                    = "${var.resource_name_prefix}-${var.environment}-container-${var.azurerm_container_group_name_suffix}"
  azurerm_container_group_network_profile_name    = "${var.resource_name_prefix}-${var.environment}-netpro-${var.azurerm_container_group_name_suffix}"
  azurerm_container_group_network_interface_name  = "${var.resource_name_prefix}-${var.environment}-netint-${var.azurerm_container_group_name_suffix}"
  azurerm_container_name                          = "${var.azurerm_container_group_name_suffix}"
  azurerm_container_volume_name                   = "${var.azurerm_container_group_name_suffix}-volume"
  azurerm_storage_account_name                    = "${var.resource_name_prefix}${var.environment}sa${var.storage_account_name}"
  azurerm_storage_share_name                      = "${var.resource_name_prefix}-${var.environment}-sashare-${var.storage_account_share_name_suffix}"
  azurerm_log_analytics_workspace_name            = "${var.resource_name_prefix}-${var.environment}-log-analytics-workspace-${var.log_analytics_workspace_name}"
}
