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
  description = "The configuration of primary group"
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
}

variable "tags" {
  description = "Tags"
  type        = any
  default     = {}
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
}

variable "escalations" {
  description = "Escalations"
  type        = any
  default     = {}
}

variable "maintenances" {
  description = "Maintenances"
  type        = any
  default     = {}
}

variable "maintenance_schedules" {
  description = "Maintenance Schedules"
  type        = any
  default     = {}
}

variable "maintenance_notifications" {
  description = "Maintenance Notifications"
  type        = any
  default     = {}
}

variable "contacts" {
  description = "Contacts"
  type        = any
  default     = {}
}

variable "statuspages" {
  description = "Status Pages"
  type        = any
  default     = {}
}

variable "credentials" {
  description = "Credentials"
  type        = any
  default     = {}
}

variable "dashboards" {
  description = "Dashboards"
  type        = any
  default     = {}
}

variable "sla_reports" {
  description = "SLA Reports"
  type        = any
  default     = {}
}

variable "scheduled_reports" {
  description = "Scheduled Reports"
  type        = any
  default     = {}
}

variable "service_variables" {
  description = "Service Variables"
  type        = any
  default     = {}
}

variable "subaccounts" {
  description = "Subaccounts"
  type        = any
  default     = {}
}

variable "users" {
  description = "Users"
  type        = any
  default     = {}
}
