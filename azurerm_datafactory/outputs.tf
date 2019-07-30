output "azurerm_data_factory_name" {
  description = "The name assigned to the Data Factory created."
  value       = "${local.azurerm_data_factory_name}"
}

output "azurerm_data_factory_github_configuration_account_name" {
  description = "The GitHub account name associated with Data Factory."
  value       = "${var.azurerm_data_factory_github_configuration_account_name}"
}

output "azurerm_data_factory_github_configuration_branch_name" {
  description = "The GitHub branch name associated with Data Factory."
  value       = "${var.azurerm_data_factory_github_configuration_branch_name}"
}

output "azurerm_data_factory_github_configuration_git_url" {
  description = "The GitHub url name associated with Data Factory. Defaults to https://github.com for free accounts. Should be set instead to https://github.{MY_DOMAIN}.com for enterprise accounts."
  value       = "${var.azurerm_data_factory_github_configuration_git_url}"
}

output "azurerm_data_factory_github_configuration_repository_name" {
  description = "The GitHub repository name associated with Data Factory."
  value       = "${var.azurerm_data_factory_github_configuration_repository_name}"
}

output "azurerm_data_factory_github_configuration_root_folder" {
  description = "The GitHub root folder associated with Data Factory. Default to /"
  value       = "${var.azurerm_data_factory_github_configuration_root_folder}"
}
