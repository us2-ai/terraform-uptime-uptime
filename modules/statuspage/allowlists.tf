# Attribute allowlists for the status page sub-resource collections
#
# Collection variables are typed `any` and read with `try(each.value.<attr>, ...)`, so an attribute
# the module does not read would otherwise be silently discarded. Each collection validates its
# attribute names against the corresponding entry here. Adding an attribute to the module means
# adding it here too, or callers cannot set it.
#
# Referencing a local from a `validation` block requires Terraform/OpenTofu >= 1.9.

locals {
  allowed_attributes = {
    components = [
      "auto_status_down", "auto_status_up", "description", "group_id", "is_group", "name",
      "service_id", "sorting_weight", "status"
    ]
    incidents = [
      "affected_components", "ends_at", "incident_type", "include_in_global_metrics", "name",
      "notify_subscribers", "send_maintenance_start_notification", "starts_at",
      "update_component_status", "updates"
    ]
    metrics = [
      "is_visible", "name", "service_id"
    ]
    subscribers = [
      "force_validation_sms", "target", "type"
    ]
    subscription_domain_allows = [
      "domain"
    ]
    subscription_domain_blocks = [
      "domain"
    ]
    users = [
      "email", "first_name", "is_active", "last_name"
    ]
  }
}
