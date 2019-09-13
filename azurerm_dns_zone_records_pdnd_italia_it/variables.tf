# Generic variables

variable "environment" {
  description = "The nick name identifying the type of environment (i.e. test, staging, production)."
}

variable "kubernetes_environment" {
  description = "The environment where the Kubernetes cluster lives."
}

variable "location" {
  description = "The data center location where all resources will be put into."
}

variable "resource_name_prefix" {
  description = "The prefix used to name all resources created."
}

variable "kubernetes_resource_group_name" {
  description = "The resource group of the kubernetes cluster."
}

variable "kubernetes_public_ip_name" {
  description = "The name suffix of the public IP address to allocate."
}

variable "dns_record_ttl" {
  description = "The DNS records TTL in seconds."
}

variable "kubernetes_cname_records" {
  type        = "list"
  description = "The list of DNS CNAME records. Keys must include name, record (both string values)."
}

locals {
  azurerm_resource_group_name = "${var.resource_name_prefix}-${var.environment}"
  kubernetes_public_ip_name   = "${var.resource_name_prefix}-${var.kubernetes_environment}-pip-${var.kubernetes_public_ip_name}"
}
