output "azurerm_storage_account_name" {
  description = "The name of the storage account generated."
  value       = "${local.azurerm_storage_account_name}"
}

output "azurerm_storage_account_account_tier" {
  description = "The Azure storage account tier."
  value       = "${var.azurerm_storage_account_account_tier}"
}

output "azurerm_storage_account_replication_type" {
  description = "The Azure storage account replication type."
  value       = "${var.azurerm_storage_account_account_replication_type}"
}

output "azurerm_storage_account_is_hns_enabled" {
  description = "Whether or not to enable the Data Lake Storage Account v2 features."
  value       = "${var.azurerm_storage_account_is_hns_enabled}"
}
