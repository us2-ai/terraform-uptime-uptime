# Attribute allowlist for integration settings (union across all integration types)
#
# Collection variables are typed `any` and read with `try(each.value.<attr>, ...)`, so an attribute
# the module does not read would otherwise be silently discarded. Each collection validates its
# attribute names against the corresponding entry here. Adding an attribute to the module means
# adding it here too, or callers cannot set it.
#
# Referencing a local from a `validation` block requires Terraform/OpenTofu >= 1.9.

locals {
  allowed_attributes = {
    settings = [
      "api_email", "api_endpoint", "api_id", "api_key", "api_token", "app_key", "auto_resolve",
      "cachet_url", "channel", "component", "container", "custom_field_id_account_name",
      "custom_field_id_check_name", "custom_field_id_check_url", "custom_fields_json",
      "data_source_name", "dataset_name", "email", "headers", "jira_subdomain", "labels", "metric",
      "page", "postback_url", "priority", "project_key", "region", "routing_key", "service_key",
      "statuspage_id", "tags", "teams", "token", "use_legacy_payload", "user", "wavefront_url",
      "webhook_url"
    ]
  }
}
