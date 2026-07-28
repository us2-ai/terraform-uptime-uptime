# Attribute allowlists for the wrapper module (mirrors the root module's arguments)
#
# Collection variables are typed `any` and read with `try(each.value.<attr>, ...)`, so an attribute
# the module does not read would otherwise be silently discarded. Each collection validates its
# attribute names against the corresponding entry here. Adding an attribute to the module means
# adding it here too, or callers cannot set it.
#
# Referencing a local from a `validation` block requires Terraform/OpenTofu >= 1.9.

locals {
  allowed_attributes = {
    defaults = [
      "additional_tags", "address", "check_version", "checks", "color_hex", "config",
      "contact_groups", "contacts", "create", "create_group", "create_tag", "credentials",
      "dashboards", "dns_record_type", "dns_server", "encryption", "escalations", "expect_string",
      "expect_string_type", "groups", "headers", "include_in_global_metrics", "integrations",
      "interval", "is_paused", "locations", "maintenance_notifications", "maintenance_schedules",
      "maintenances", "name", "notes", "num_retries", "password", "port", "proxy",
      "scheduled_reports", "script", "send_resolved_notifications", "send_string", "sensitivity",
      "service_variables", "sla", "sla_reports", "sla_uptime", "status_code", "statuspages",
      "subaccounts", "tags", "threshold", "use_ip_version", "username", "users"
    ]
    items = [
      "additional_tags", "address", "check_version", "checks", "color_hex", "config",
      "contact_groups", "contacts", "create", "create_group", "create_tag", "credentials",
      "dashboards", "dns_record_type", "dns_server", "encryption", "escalations", "expect_string",
      "expect_string_type", "groups", "headers", "include_in_global_metrics", "integrations",
      "interval", "is_paused", "locations", "maintenance_notifications", "maintenance_schedules",
      "maintenances", "name", "notes", "num_retries", "password", "port", "proxy",
      "scheduled_reports", "script", "send_resolved_notifications", "send_string", "sensitivity",
      "service_variables", "sla", "sla_reports", "sla_uptime", "status_code", "statuspages",
      "subaccounts", "tags", "threshold", "use_ip_version", "username", "users"
    ]
  }
}
