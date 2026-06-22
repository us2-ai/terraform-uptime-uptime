################
# Uptime Check #
################
variable "create" {
  description = "Create"
  type        = bool
  default     = true
}

variable "type" {
  description = "The type of check to create"
  type        = string

  validation {
    condition     = can(regex("^(api|blacklist|cloudstatus|dns|heartbeat|http|icmp|imap|malware|ntp|pagespeed|pop|rdap|rum2|smtp|sslcert|ssh|tcp|transaction|udp|webhook|whois)$", var.type))
    error_message = "Must be a valid type of check"
  }
}

variable "address" {
  description = "Address"
  type        = string
  default     = null
}

variable "name" {
  description = "Name"
  type        = string
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

variable "is_paused" {
  description = "Is paused?"
  type        = bool
  default     = false
}

variable "notes" {
  description = "Notes"
  type        = string
  default     = null
}

variable "num_retries" {
  description = "The number of retries"
  type        = number
  default     = null
}

variable "tags" {
  description = "Tags for which this resource belongs to"
  type        = list(string)
  default     = []
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
  description = "Include in global metrics"
  type        = bool
  default     = false
}

variable "interval" {
  description = "The interval between checks"
  type        = number
  default     = null
}

variable "locations" {
  description = "The list of locations"
  type        = list(string)
  default     = []
}

variable "sensitivity" {
  description = "Sensitivity"
  type        = number
  default     = null
}

variable "sla" {
  description = "SLA"
  type        = any
  default     = {}
}

variable "threshold" {
  description = "The threshold to trigger an alert"
  type        = number
  default     = null
}

variable "config" {
  description = "SSLcert configuration"
  type        = any
  default     = {}
}

variable "port" {
  description = "Port"
  type        = number
  default     = null
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

variable "pagespeed_config" {
  description = "Pagespeed check configuration"
  type        = any
  default     = {}
}

variable "pagespeed_headers" {
  description = "Pagespeed headers (JSON string)"
  type        = string
  default     = null
  sensitive   = true
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

variable "cloudstatus_config" {
  description = <<-EOT
    Cloudstatus check configuration. Supported keys:
    group (number), monitoring_type (string: ALL or SPECIFIC),
    notify_only_on_down (bool), service_name (string, deprecated/legacy),
    service_titles (list(string)), services (list(number)).
  EOT
  type        = any
  default     = {}
}
