
# New infrastructure

resource "azuread_application" "app" {
  name                       = "${local.azuread_application_name}"
  homepage                   = "${local.azuread_application_homepage}"
  identifier_uris            = ["${var.azuread_application_identifier_uris}"]
  reply_urls                 = ["${var.azuread_application_reply_urls}"]
  available_to_other_tenants = "${var.azuread_application_available_to_other_tenants}"
  oauth2_allow_implicit_flow = "${var.azuread_application_oauth2_allow_implicit_flow}"
  type                       = "${var.azuread_application_type}"
}
