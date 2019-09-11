# Existing infrastructure

data "azurerm_resource_group" "rg" {
  name = "${local.azurerm_resource_group_name}"
}

data "azurerm_virtual_network" "vnet" {
  name                = "${local.azurerm_virtual_network_name}"
  resource_group_name = "${data.azurerm_resource_group.rg.name}"
}

data "azurerm_storage_account" "stg" {
  name                = "${var.azurerm_storage_account_name}"
  resource_group_name = "${data.azurerm_resource_group.rg.name}"
}

# New infrastructure

resource "azurerm_container_group" "container" {
  name                = "${local.azurerm_container_group_name}"
  location            = "${data.azurerm_resource_group.rg.location}"
  resource_group_name = "${data.azurerm_resource_group.rg.name}"
  network_profile_id  = "${data.azurerm_virtual_network.vnet.id}"
  ip_address_type     = "${var.azurerm_container_group_ip_address_type}"
  dns_name_label      = "${local.azurerm_container_group_dns_name}"
  os_type             = "Linux"

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
      "SFTP_USERS" = "${var.azurerm_container_group_container_sftp_env_users}"
    }

    volume {
      name       = "${local.azurerm_container_volume_name}"
      mount_path = "/home/${var.azurerm_container_group_container_sftp_user}/upload"
      read_only  = false
      share_name = "${azurerm_storage_share.aci-share.name}"

      storage_account_name  = "${data.azurerm_storage_account.stg.name}"
      storage_account_key   = "${data.azurerm_storage_account.stg.primary_access_key}"
    }
  }

  tags = {
    environment = "${var.environment}"
  }
}

