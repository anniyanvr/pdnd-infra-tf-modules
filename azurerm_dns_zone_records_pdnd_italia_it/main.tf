# Existing infrastructure

data "azurerm_resource_group" "rg" {
  name = "${local.azurerm_resource_group_name}"
}

data "azurerm_resource_group" "aks_rg" {
  name = "${var.kubernetes_resource_group_name}"
}

data "azurerm_public_ip" "kubernetes_public_ip" {
  name                = "${local.kubernetes_public_ip_name}"
  resource_group_name = "${data.azurerm_resource_group.aks_rg.name}"
}

# New infrastructure

# The module dynamically creates only A and CNAME records, as other record
# type still don't support dynamical record value definition (which will
# be instead supported from Terraform 0.12 with loops)

# Name servers for dev.pdnd.italia.it
resource "azurerm_dns_ns_record" "dev_ns_records" {
  name                = "dev"
  zone_name           = "pdnd.italia.it"
  resource_group_name = "${data.azurerm_resource_group.rg.name}"
  ttl                 = "${var.dns_record_ttl}"

  records = [
    "ns1-03.azure-dns.com",
    "ns2-03.azure-dns.net",
    "ns3-03.azure-dns.org",
    "ns4-03.azure-dns.info"
  ]

  tags = {
    environment = "${var.environment}"
  }
}

# Name servers for prod.pdnd.italia.it
resource "azurerm_dns_ns_record" "prod_ns_records" {
  name                = "prod"
  zone_name           = "pdnd.italia.it"
  resource_group_name = "${data.azurerm_resource_group.rg.name}"
  ttl                 = "${var.dns_record_ttl}"

  records = [
    "ns1-06.azure-dns.com",
    "ns2-06.azure-dns.net",
    "ns3-06.azure-dns.org",
    "ns4-06.azure-dns.info"
  ]

  tags = {
    environment = "${var.environment}"
  }
}

# CNAME records for kubernetes services
resource "azurerm_dns_cname_record" "kubernetes_cname_records" {
  count               = "${length(var.kubernetes_cname_records)}"
  name                = "${var.kubernetes_cname_records[count.index]}"
  resource_group_name = "${data.azurerm_resource_group.rg.name}"
  zone_name           = "pdnd.italia.it"
  ttl                 = "${var.dns_record_ttl}"
  record              = "${var.kubernetes_cname_records[count.index]}.prod.pdnd.italia.it"
}

# Website - start

resource "azurerm_dns_a_record" "root_to_kubernetes" {
  name                = "@"
  zone_name           = "pdnd.italia.it"
  resource_group_name = "${data.azurerm_resource_group.rg.name}"
  ttl                 = "${var.dns_record_ttl}"
  records             = ["${data.azurerm_public_ip.kubernetes_public_ip.ip_address}"]
}

# Website - end
