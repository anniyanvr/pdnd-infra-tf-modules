# Existing infrastructure

data "azurerm_resource_group" "rg" {
  name = "${local.azurerm_resource_group_name}"
}

# New infrastructure

resource "azurerm_databricks_workspace" "databricks" {
  name                        = "${local.azurerm_databricks_workspace_name}"
  resource_group_name         = "${data.azurerm_resource_group.rg.name}"
  location                    = "${var.location}"
  sku                         = "${var.azurerm_databricks_workspace_sku}"
  managed_resource_group_name = "${local.azurerm_databricks_workspace_managed_rg_name}"

  tags = {
    environment = "${var.environment}"
  }
}
