# Existing infrastructure

data "azurerm_resource_group" "rg" {
  name = "${local.azurerm_resource_group_name}"
}

data "azurerm_virtual_network" "vnet" {
  name                = "${local.azurerm_virtual_network_name}"
  resource_group_name = "${data.azurerm_resource_group.rg.name}"
}

data "azurerm_storage_account" "stg" {
  name                = "${local.azurerm_storage_account_name}"
  resource_group_name = "${data.azurerm_resource_group.rg.name}"
}

data "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  name                = "${local.azurerm_log_analytics_workspace_name}"
  resource_group_name = "${data.azurerm_resource_group.rg.name}"
}

data "azurerm_subnet" "subnet" {
  name                 = "${local.azurerm_subnet_name}"
  virtual_network_name = "${data.azurerm_virtual_network.vnet.name}"
  resource_group_name  = "${data.azurerm_resource_group.rg.name}"
}

data "azurerm_key_vault" "key_vault" {
  name                = "${local.azurerm_key_vault_name}"
  resource_group_name = "${data.azurerm_resource_group.rg.name}"
}

data "azurerm_key_vault_secret" "sftp_user_password" {
  name         = "${var.key_vault_secret_sftp_user_pass}"
  key_vault_id = "${data.azurerm_key_vault.key_vault.id}"
}

# New infrastructure

resource "azurerm_network_profile" "network_profile" {
  name                = "${local.azurerm_container_group_network_profile_name}"
  resource_group_name = "${data.azurerm_resource_group.rg.name}"
  location            = "${data.azurerm_resource_group.rg.location}"

  container_network_interface {
    name = "${local.azurerm_container_group_network_interface_name}"

    ip_configuration {
      name      = "${local.azurerm_container_group_network_interface_name}-ipconfig"
      subnet_id = "${data.azurerm_subnet.subnet.id}"
    }
  }
}

resource "azurerm_container_group" "container" {
  name                = "${local.azurerm_container_group_name}"
  resource_group_name = "${data.azurerm_resource_group.rg.name}"
  location            = "${data.azurerm_resource_group.rg.location}"
  # network_profile_id  = "${azurerm_network_profile.network_profile.id}"
  ip_address_type     = "${var.azurerm_container_group_ip_address_type}"
  os_type             = "Linux"

  diagnostics {
    log_analytics {
      log_type      = "ContainerInsights"
      workspace_id  = "${data.azurerm_log_analytics_workspace.log_analytics_workspace.workspace_id}"
      workspace_key = "${data.azurerm_log_analytics_workspace.log_analytics_workspace.primary_shared_key}"
    }
  }

  container {
    name   = "${local.azurerm_container_name}"
    image  = "${var.azurerm_container_group_container_image}"
    cpu    = "${var.azurerm_container_group_container_cpu}"
    memory = "${var.azurerm_container_group_container_memory}"

    ports {
      port     = "${var.azurerm_container_group_container_port}"
      protocol = "TCP"
    }

    environment_variables {
      "SFTP_USERS" = "${var.azurerm_container_group_container_sftp_user}:${data.azurerm_key_vault_secret.sftp_user_password.value}:1001"
    }

    volume {
      name       = "${local.azurerm_container_volume_name}"
      mount_path = "/home/${var.azurerm_container_group_container_sftp_user}/${local.azurerm_storage_share_name}"
      read_only  = false
      share_name = "${local.azurerm_storage_share_name}"

      storage_account_name  = "${data.azurerm_storage_account.stg.name}"
      storage_account_key   = "${data.azurerm_storage_account.stg.primary_access_key}"
    }
  }

  tags = {
    environment = "${var.environment}"
  }
}

