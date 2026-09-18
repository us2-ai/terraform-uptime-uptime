#################
# Uptime Module #
#################
variable "create" {
  description = "Create resources in module"
  type        = bool
  default     = true
}

variable "create_group" {
  description = "Create primary group for all checks"
  type        = bool
  default     = true
}

variable "create_tag" {
  description = "Create primary tag for all checks"
  type        = bool
  default     = true
}

variable "name" {
  description = "Global name to be used on all the resources as identifier"
  type        = string
}

variable "color_hex" {
  description = "The color of the primary tag."
  type        = string
  default     = null
}

variable "config" {
  description = "The configuration of the primary check group. This is not a default for a check's `config` block, which is a different, non-overlapping schema."
  type        = any
  default     = {}
}

variable "address" {
  description = "FQDN of the system."
  type        = string
  default     = null
}

variable "port" {
  description = "Port"
  type        = number
  default     = null
}

variable "script" {
  description = "API Script (JSON)"
  type        = string
  default     = null
}

variable "contact_groups" {
  description = "Contact Groups"
  type        = list(string)
  default     = []
}

variable "encryption" {
  description = "Encryption"
  type        = bool
  default     = false
}

variable "dns_record_type" {
  description = "The DNS record type"
  type        = string
  default     = null
}

variable "dns_server" {
  description = "The DNS server to use"
  type        = string
  default     = null
}

variable "expect_string" {
  description = "Expected string"
  type        = string
  default     = null
}

variable "expect_string_type" {
  description = "Expected string type"
  type        = string
  default     = null
}

variable "headers" {
  description = "HTTP headers"
  type        = map(list(string))
  default     = {}
}

variable "include_in_global_metrics" {
  description = "Global include in global metrics"
  type        = bool
  default     = null
}

variable "is_paused" {
  description = "Global pause"
  type        = bool
  default     = null
}

variable "notes" {
  description = "Global Notes"
  type        = string
  default     = null
}

variable "sla" {
  description = "Global SLA settings"
  type        = any
  default     = {}
}

variable "groups" {
  description = "Groups"
  type        = any
  default     = {}

  # Rejects attributes the module does not read; see allowlists.tf.
  validation {
    condition = alltrue([
      for k, v in var.groups : length(setsubtract(try(keys(v), []), local.allowed_attributes.groups)) == 0
    ])
    error_message = format(
      "var.groups has unsupported attribute(s): %s. Valid attributes: %s.",
      join(", ", flatten([
        for k, v in var.groups : [
          for a in setsubtract(try(keys(v), []), local.allowed_attributes.groups) : format("%s.%s", k, a)
        ]
      ])),
      join(", ", local.allowed_attributes.groups)
    )
  }
}

variable "tags" {
  description = "Tags"
  type        = any
  default     = {}

  # Rejects attributes the module does not read; see allowlists.tf.
  validation {
    condition = alltrue([
      for k, v in var.tags : length(setsubtract(try(keys(v), []), local.allowed_attributes.tags)) == 0
    ])
    error_message = format(
      "var.tags has unsupported attribute(s): %s. Valid attributes: %s.",
      join(", ", flatten([
        for k, v in var.tags : [
          for a in setsubtract(try(keys(v), []), local.allowed_attributes.tags) : format("%s.%s", k, a)
        ]
      ])),
      join(", ", local.allowed_attributes.tags)
    )
  }
}

variable "additional_tags" {
  description = "Additional tags to be added"
  type        = list(string)
  default     = []
}

variable "checks" {
  description = "Checks"
  type        = any
  default     = {}

  # Rejects attributes the module does not read; see allowlists.tf.
  validation {
    condition = alltrue([
      for k, v in var.checks : length(setsubtract(try(keys(v), []), local.allowed_attributes.checks)) == 0
    ])
    error_message = format(
      "var.checks has unsupported attribute(s): %s. Valid attributes: %s.",
      join(", ", flatten([
        for k, v in var.checks : [
          for a in setsubtract(try(keys(v), []), local.allowed_attributes.checks) : format("%s.%s", k, a)
        ]
      ])),
      join(", ", local.allowed_attributes.checks)
    )
  }
}

variable "interval" {
  description = "Check frequency in minutes"
  type        = number
  default     = null
}

variable "sensitivity" {
  description = "Number of locations that must be down before alerting"
  type        = number
  default     = null
}

variable "num_retries" {
  description = "Number of retries before marking check as down"
  type        = number
  default     = null
}

variable "threshold" {
  description = "Threshold for alerts"
  type        = number
  default     = null
}

variable "locations" {
  description = "Locations"
  type        = list(string)
  default     = []
}

variable "lookup_private_locations" {
  description = "Query the account's private monitoring locations and expose them via the `private_locations` and `private_check_locations` outputs. The lookup is performed automatically for any check that sets `use_private_locations`, so this only needs to be set when you want the outputs on their own."
  type        = bool
  default     = false
}

variable "username" {
  description = "Username"
  type        = string
  default     = null
}

variable "password" {
  description = "Password"
  type        = string
  default     = null
  sensitive   = true
}

variable "proxy" {
  description = "Proxy"
  type        = string
  default     = null
}

variable "send_string" {
  description = "String to POST"
  type        = string
  default     = null
}

variable "status_code" {
  description = "Expected HTTP code returned"
  type        = string
  default     = null
}

variable "check_version" {
  description = "Check version"
  type        = number
  default     = null
}

variable "use_ip_version" {
  description = "Use IP Version"
  type        = string
  default     = null
}

variable "send_resolved_notifications" {
  description = "Send resolved notifications"
  type        = bool
  default     = null
}

variable "sla_uptime" {
  description = "SLA uptime (string, for RUM2 checks)"
  type        = string
  default     = null
}

variable "integrations" {
  description = "Integrations"
  type        = any
  default     = {}

  # Rejects attributes the module does not read; see allowlists.tf.
  validation {
    condition = alltrue([
      for k, v in var.integrations : length(setsubtract(try(keys(v), []), local.allowed_attributes.integrations)) == 0
    ])
    error_message = format(
      "var.integrations has unsupported attribute(s): %s. Valid attributes: %s.",
      join(", ", flatten([
        for k, v in var.integrations : [
          for a in setsubtract(try(keys(v), []), local.allowed_attributes.integrations) : format("%s.%s", k, a)
        ]
      ])),
      join(", ", local.allowed_attributes.integrations)
    )
  }
}

variable "escalations" {
  description = "Escalations"
  type        = any
  default     = {}

  # Rejects attributes the module does not read; see allowlists.tf.
  validation {
    condition = alltrue([
      for k, v in var.escalations : length(setsubtract(try(keys(v), []), local.allowed_attributes.escalations)) == 0
    ])
    error_message = format(
      "var.escalations has unsupported attribute(s): %s. Valid attributes: %s.",
      join(", ", flatten([
        for k, v in var.escalations : [
          for a in setsubtract(try(keys(v), []), local.allowed_attributes.escalations) : format("%s.%s", k, a)
        ]
      ])),
      join(", ", local.allowed_attributes.escalations)
    )
  }
}

# tflint-ignore: terraform_unused_declarations # Tombstone: referenced only by its own validation, on purpose. Removed in 4.0.0.
variable "maintenances" {
  description = "REMOVED in v3.0.0. Provider 3.0.0 dropped `uptime_check_maintenance`, so per-check maintenance windows can no longer be managed here. Retained only so that an existing configuration fails with a pointer to the migration steps instead of an unexplained \"Unsupported argument\". Use `maintenance_schedules` and `maintenance_notifications` instead; see UPGRADE-3.0.md."
  type        = any
  default     = {}

  validation {
    condition     = length(var.maintenances) == 0
    error_message = "var.maintenances is no longer supported: provider 3.0.0 removed uptime_check_maintenance. Migrate each window to maintenance_schedules while still on module 2.x and provider 2.34, then upgrade. UPGRADE-3.0.md has the steps and the terraform state rm addresses."
  }
}

variable "maintenance_schedules" {
  description = "Maintenance Schedules"
  type        = any
  default     = {}

  # Rejects attributes the module does not read; see allowlists.tf.
  validation {
    condition = alltrue([
      for k, v in var.maintenance_schedules : length(setsubtract(try(keys(v), []), local.allowed_attributes.maintenance_schedules)) == 0
    ])
    error_message = format(
      "var.maintenance_schedules has unsupported attribute(s): %s. Valid attributes: %s.",
      join(", ", flatten([
        for k, v in var.maintenance_schedules : [
          for a in setsubtract(try(keys(v), []), local.allowed_attributes.maintenance_schedules) : format("%s.%s", k, a)
        ]
      ])),
      join(", ", local.allowed_attributes.maintenance_schedules)
    )
  }
}

variable "maintenance_notifications" {
  description = "Maintenance Notifications"
  type        = any
  default     = {}

  # Rejects attributes the module does not read; see allowlists.tf.
  validation {
    condition = alltrue([
      for k, v in var.maintenance_notifications : length(setsubtract(try(keys(v), []), local.allowed_attributes.maintenance_notifications)) == 0
    ])
    error_message = format(
      "var.maintenance_notifications has unsupported attribute(s): %s. Valid attributes: %s.",
      join(", ", flatten([
        for k, v in var.maintenance_notifications : [
          for a in setsubtract(try(keys(v), []), local.allowed_attributes.maintenance_notifications) : format("%s.%s", k, a)
        ]
      ])),
      join(", ", local.allowed_attributes.maintenance_notifications)
    )
  }
}

variable "contacts" {
  description = "Contacts"
  type        = any
  default     = {}

  # Rejects attributes the module does not read; see allowlists.tf.
  validation {
    condition = alltrue([
      for k, v in var.contacts : length(setsubtract(try(keys(v), []), local.allowed_attributes.contacts)) == 0
    ])
    error_message = format(
      "var.contacts has unsupported attribute(s): %s. Valid attributes: %s.",
      join(", ", flatten([
        for k, v in var.contacts : [
          for a in setsubtract(try(keys(v), []), local.allowed_attributes.contacts) : format("%s.%s", k, a)
        ]
      ])),
      join(", ", local.allowed_attributes.contacts)
    )
  }
}

variable "statuspages" {
  description = "Status Pages"
  type        = any
  default     = {}

  # Rejects attributes the module does not read; see allowlists.tf.
  validation {
    condition = alltrue([
      for k, v in var.statuspages : length(setsubtract(try(keys(v), []), local.allowed_attributes.statuspages)) == 0
    ])
    error_message = format(
      "var.statuspages has unsupported attribute(s): %s. Valid attributes: %s.",
      join(", ", flatten([
        for k, v in var.statuspages : [
          for a in setsubtract(try(keys(v), []), local.allowed_attributes.statuspages) : format("%s.%s", k, a)
        ]
      ])),
      join(", ", local.allowed_attributes.statuspages)
    )
  }
}

variable "credentials" {
  description = "Credentials"
  type        = any
  default     = {}

  # Rejects attributes the module does not read; see allowlists.tf.
  validation {
    condition = alltrue([
      for k, v in var.credentials : length(setsubtract(try(keys(v), []), local.allowed_attributes.credentials)) == 0
    ])
    error_message = format(
      "var.credentials has unsupported attribute(s): %s. Valid attributes: %s.",
      join(", ", flatten([
        for k, v in var.credentials : [
          for a in setsubtract(try(keys(v), []), local.allowed_attributes.credentials) : format("%s.%s", k, a)
        ]
      ])),
      join(", ", local.allowed_attributes.credentials)
    )
  }
}

variable "dashboards" {
  description = "Dashboards"
  type        = any
  default     = {}

  # Rejects attributes the module does not read; see allowlists.tf.
  validation {
    condition = alltrue([
      for k, v in var.dashboards : length(setsubtract(try(keys(v), []), local.allowed_attributes.dashboards)) == 0
    ])
    error_message = format(
      "var.dashboards has unsupported attribute(s): %s. Valid attributes: %s.",
      join(", ", flatten([
        for k, v in var.dashboards : [
          for a in setsubtract(try(keys(v), []), local.allowed_attributes.dashboards) : format("%s.%s", k, a)
        ]
      ])),
      join(", ", local.allowed_attributes.dashboards)
    )
  }
}

variable "sla_reports" {
  description = "SLA Reports"
  type        = any
  default     = {}

  # Rejects attributes the module does not read; see allowlists.tf.
  validation {
    condition = alltrue([
      for k, v in var.sla_reports : length(setsubtract(try(keys(v), []), local.allowed_attributes.sla_reports)) == 0
    ])
    error_message = format(
      "var.sla_reports has unsupported attribute(s): %s. Valid attributes: %s.",
      join(", ", flatten([
        for k, v in var.sla_reports : [
          for a in setsubtract(try(keys(v), []), local.allowed_attributes.sla_reports) : format("%s.%s", k, a)
        ]
      ])),
      join(", ", local.allowed_attributes.sla_reports)
    )
  }
}

variable "scheduled_reports" {
  description = "Scheduled Reports"
  type        = any
  default     = {}

  # Rejects attributes the module does not read; see allowlists.tf.
  validation {
    condition = alltrue([
      for k, v in var.scheduled_reports : length(setsubtract(try(keys(v), []), local.allowed_attributes.scheduled_reports)) == 0
    ])
    error_message = format(
      "var.scheduled_reports has unsupported attribute(s): %s. Valid attributes: %s.",
      join(", ", flatten([
        for k, v in var.scheduled_reports : [
          for a in setsubtract(try(keys(v), []), local.allowed_attributes.scheduled_reports) : format("%s.%s", k, a)
        ]
      ])),
      join(", ", local.allowed_attributes.scheduled_reports)
    )
  }
}

variable "service_variables" {
  description = "Service Variables"
  type        = any
  default     = {}

  # Rejects attributes the module does not read; see allowlists.tf.
  validation {
    condition = alltrue([
      for k, v in var.service_variables : length(setsubtract(try(keys(v), []), local.allowed_attributes.service_variables)) == 0
    ])
    error_message = format(
      "var.service_variables has unsupported attribute(s): %s. Valid attributes: %s.",
      join(", ", flatten([
        for k, v in var.service_variables : [
          for a in setsubtract(try(keys(v), []), local.allowed_attributes.service_variables) : format("%s.%s", k, a)
        ]
      ])),
      join(", ", local.allowed_attributes.service_variables)
    )
  }
}

variable "subaccounts" {
  description = "Subaccounts"
  type        = any
  default     = {}

  # Rejects attributes the module does not read; see allowlists.tf.
  validation {
    condition = alltrue([
      for k, v in var.subaccounts : length(setsubtract(try(keys(v), []), local.allowed_attributes.subaccounts)) == 0
    ])
    error_message = format(
      "var.subaccounts has unsupported attribute(s): %s. Valid attributes: %s.",
      join(", ", flatten([
        for k, v in var.subaccounts : [
          for a in setsubtract(try(keys(v), []), local.allowed_attributes.subaccounts) : format("%s.%s", k, a)
        ]
      ])),
      join(", ", local.allowed_attributes.subaccounts)
    )
  }
}

variable "users" {
  description = "Users"
  type        = any
  default     = {}

  # Rejects attributes the module does not read; see allowlists.tf.
  validation {
    condition = alltrue([
      for k, v in var.users : length(setsubtract(try(keys(v), []), local.allowed_attributes.users)) == 0
    ])
    error_message = format(
      "var.users has unsupported attribute(s): %s. Valid attributes: %s.",
      join(", ", flatten([
        for k, v in var.users : [
          for a in setsubtract(try(keys(v), []), local.allowed_attributes.users) : format("%s.%s", k, a)
        ]
      ])),
      join(", ", local.allowed_attributes.users)
    )
  }
}
