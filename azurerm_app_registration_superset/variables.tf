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

# App registration variables

variable "dns_domain_name_suffix" {
  description = "The DNS domain name suffix used to build the application homepage."
}

variable "azuread_application_name_suffix" {
  description = " The display name for the application."
}

variable "azuread_application_identifier_uris" {
  description = "A list of user-defined URI(s) that uniquely identify a Web application within it's Azure AD tenant, or within a verified custom domain if the application is multi-tenant."
  type        = "list"
}

variable "azuread_application_reply_urls" {
  description = " A list of URLs that user tokens are sent to for sign in, or the redirect URIs that OAuth 2.0 authorization codes and access tokens are sent to."
  type        = "list"
}

variable "azuread_application_available_to_other_tenants" {
  description = "Is this Azure AD Application available to other tenants."
}

variable "azuread_application_oauth2_allow_implicit_flow" {
  description = "Does this Azure AD Application allow OAuth2.0 implicit flow tokens?."
}

variable "azuread_application_type" {
  description = " Type of an application: webapp/api or native. Defaults to webapp/api. For native apps type identifier_uris property can not not be set."
}

locals {
  # Define resource names based on the following convention:
  # {azurerm_resource_name_prefix}-RESOURCE_TYPE-{environment}
  azurerm_resource_group_name  = "${var.resource_name_prefix}-${var.environment}-rg"
  azuread_application_name     = "${var.resource_name_prefix}-${var.environment}-app-${var.azuread_application_name_suffix}"
  azuread_application_homepage = "https://${var.azuread_application_name_suffix}.${var.environment}.${var.dns_domain_name_suffix}"
}
