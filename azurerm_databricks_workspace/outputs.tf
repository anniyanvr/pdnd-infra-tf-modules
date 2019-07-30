output "azurerm_databricks_workspace_name" {
  value         = "${local.azurerm_databricks_workspace_name}"
  description   = "The Data Bricks workspace name."
}

output "azurerm_databricks_workspace_managed_rg_name" {
  value         = "${local.azurerm_databricks_workspace_managed_rg_name}"
  description   = "The Name of the resource group used by Data Bricks to save its resources."
}
