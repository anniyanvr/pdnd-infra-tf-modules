output "azurerm_dns_zone_name" {
  description = "The DNS zone configured where records have been configured."
  value       = "${azurerm_dns_ns_record.dev_ns_records.zone_name}"
}
