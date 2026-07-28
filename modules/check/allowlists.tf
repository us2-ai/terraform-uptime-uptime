# Attribute allowlists for the check configuration blocks
#
# Collection variables are typed `any` and read with `try(each.value.<attr>, ...)`, so an attribute
# the module does not read would otherwise be silently discarded. Each collection validates its
# attribute names against the corresponding entry here. Adding an attribute to the module means
# adding it here too, or callers cannot set it.
#
# Referencing a local from a `validation` block requires Terraform/OpenTofu >= 1.9.

locals {
  allowed_attributes = {
    cloudstatus_config = [
      "group", "monitoring_type", "notify_only_on_down", "service_name", "service_titles",
      "services"
    ]
    config = [
      "crl", "fingerprint", "first_element_only", "ignore_authority_warnings", "ignore_sct",
      "issuer", "match", "min_version", "protocol", "resolve", "self_signed", "url"
    ]
    pagespeed_config = [
      "connection_throttling", "emulated_device", "exclude_urls", "uptime_grade_threshold"
    ]
  }
}
