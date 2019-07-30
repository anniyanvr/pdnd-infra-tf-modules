data "azurerm_resource_group" "rg" {
  name = "${local.azurerm_resource_group_name}"
}

# New infrastructure resources

resource "azurerm_data_factory" "data_factory" {
  name                 = "${local.azurerm_data_factory_name}"
  resource_group_name  = "${data.azurerm_resource_group.rg.name}"
  location             = "${data.azurerm_resource_group.rg.location}"

  github_configuration {
    account_name    = "${var.azurerm_data_factory_github_configuration_account_name}"
    branch_name     = "${local.azurerm_data_factory_github_configuration_branch_name}"
    git_url         = "${var.azurerm_data_factory_github_configuration_git_url}"
    repository_name = "${var.azurerm_data_factory_github_configuration_repository_name}"
    root_folder     = "${var.azurerm_data_factory_github_configuration_root_folder}"
  }

  tags = {
    environment = "${var.environment}"
  }
}
