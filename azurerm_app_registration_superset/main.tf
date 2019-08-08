# New infrastructure

resource "azuread_application" "app" {
  name                       = "${local.azuread_application_name}"
  homepage                   = "${local.azuread_application_homepage}"
  identifier_uris            = ["${var.azuread_application_identifier_uris}"]
  reply_urls                 = ["${var.azuread_application_reply_urls}"]
  available_to_other_tenants = "${var.azuread_application_available_to_other_tenants}"
  oauth2_allow_implicit_flow = "${var.azuread_application_oauth2_allow_implicit_flow}"
  type                       = "${var.azuread_application_type}"

  # TODO: To be dynamically defined once using Terraform 0.12 (with loop support)

  # API Graph
  required_resource_access {
    resource_app_id = "00000003-0000-0000-c000-000000000000"

    resource_access {
      id   = "e1fe6dd8-ba31-4d61-89e7-88639da4683d"
      type = "Scope"
    }

    resource_access {
      id   = "a154be20-db9c-4678-8ab7-66f6cc099a59"
      type = "Scope"
    }
  }

  # Active Directory Graph
  required_resource_access {
    resource_app_id = "00000002-0000-0000-c000-000000000000"

    resource_access {
      id   = "311a71cc-e848-46a1-bdf8-97ff7156d8e6"
      type = "Scope"
    }

    resource_access {
      id   = "c582532d-9d9e-43bd-a97c-2667a28ce295"
      type = "Scope"
    }
  }
}

// TODO: Programmatically grant admin access to APIs
