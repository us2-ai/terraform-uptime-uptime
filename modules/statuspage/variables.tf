######################
# Uptime Status Page #
######################
variable "create" {
  description = "Create"
  type        = bool
  default     = true
}

variable "name" {
  description = "Status page name"
  type        = string
}

variable "allow_drill_down" {
  description = "Allow drill down into component details"
  type        = bool
  default     = null
}

variable "allow_pdf_report" {
  description = "Allow PDF report generation"
  type        = bool
  default     = null
}

variable "allow_search_indexing" {
  description = "Allow search engine indexing"
  type        = bool
  default     = null
}

variable "allow_subscriptions" {
  description = "REMOVED: the API derives this from the per-channel `allow_subscriptions_*` flags and ignores it on writes. Retained only so that existing configurations fail with an actionable error instead of silently having no effect. Use the per-channel flags instead."
  type        = bool
  default     = null

  validation {
    condition     = var.allow_subscriptions == null
    error_message = "allow_subscriptions is no longer honored by the Uptime.com API, which derives it from the per-channel flags. Remove it and set allow_subscriptions_email, allow_subscriptions_rss, allow_subscriptions_slack, allow_subscriptions_sms, or allow_subscriptions_webhook instead."
  }
}

variable "allow_subscriptions_email" {
  description = "Allow email subscriptions"
  type        = bool
  default     = null
}

variable "allow_subscriptions_rss" {
  description = "Allow RSS subscriptions"
  type        = bool
  default     = null
}

variable "allow_subscriptions_slack" {
  description = "Allow Slack subscriptions"
  type        = bool
  default     = null
}

variable "allow_subscriptions_sms" {
  description = "Allow SMS subscriptions"
  type        = bool
  default     = null
}

variable "allow_subscriptions_webhook" {
  description = "Allow webhook subscriptions"
  type        = bool
  default     = null
}

variable "auth_password" {
  description = "Authentication password"
  type        = string
  default     = null
  sensitive   = true
}

variable "auth_username" {
  description = "Authentication username"
  type        = string
  default     = null
}

variable "cname" {
  description = "Custom CNAME for the status page"
  type        = string
  default     = null
}

variable "company_website_url" {
  description = "Company website URL"
  type        = string
  default     = null
}

variable "contact_email" {
  description = "Contact email address"
  type        = string
  default     = null
}

variable "custom_css" {
  description = "Custom CSS rendered only under the LEGACY theme. API-managed status pages use the INSPIRE theme, so prefer `custom_css_inspire`."
  type        = string
  default     = null
}

variable "custom_css_inspire" {
  description = "Custom CSS rendered under the INSPIRE theme, the theme used by all API-managed status pages"
  type        = string
  default     = null
}

variable "custom_footer_html" {
  description = "Custom footer HTML rendered only under the LEGACY theme. API-managed status pages use the INSPIRE theme, so prefer `custom_footer_html_inspire`."
  type        = string
  default     = null
}

variable "custom_footer_html_inspire" {
  description = "Custom footer HTML rendered under the INSPIRE theme, the theme used by all API-managed status pages"
  type        = string
  default     = null
}

variable "custom_header_bg_color_hex" {
  description = "Custom header background color hex"
  type        = string
  default     = null
}

variable "custom_header_html" {
  description = "Custom header HTML rendered only under the LEGACY theme. API-managed status pages use the INSPIRE theme, so prefer `custom_header_html_inspire`."
  type        = string
  default     = null
}

variable "custom_header_html_inspire" {
  description = "Custom header HTML rendered under the INSPIRE theme, the theme used by all API-managed status pages"
  type        = string
  default     = null
}

variable "custom_header_text_color_hex" {
  description = "Custom header text color hex"
  type        = string
  default     = null
}

variable "default_history_date_range" {
  description = "Default history date range in days"
  type        = number
  default     = null
}

variable "description" {
  description = "Status page description"
  type        = string
  default     = null
}

variable "email_from" {
  description = "Email from address"
  type        = string
  default     = null
}

variable "email_reply_to" {
  description = "Email reply-to address"
  type        = string
  default     = null
}

variable "google_analytics_code" {
  description = "Google Analytics tracking code"
  type        = string
  default     = null
}

variable "hide_empty_tabs_history" {
  description = "Hide empty tabs in history"
  type        = bool
  default     = null
}

variable "max_visible_component_days" {
  description = "Maximum visible component days on date picker"
  type        = number
  default     = null
}

variable "page_type" {
  description = "Page type"
  type        = string
  default     = null
}

variable "show_active_incidents" {
  description = "Show active incidents"
  type        = bool
  default     = null
}

variable "show_component_history" {
  description = "Show component history"
  type        = bool
  default     = null
}

variable "show_component_response_time" {
  description = "Show component response time"
  type        = bool
  default     = null
}

variable "show_history_snake" {
  description = "Show history snake visualization"
  type        = bool
  default     = null
}

variable "show_history_tab" {
  description = "Show history tab"
  type        = bool
  default     = null
}

variable "show_past_incidents" {
  description = "Show past incidents"
  type        = bool
  default     = null
}

variable "show_status_tab" {
  description = "Show status tab"
  type        = bool
  default     = null
}

variable "show_summary_metrics" {
  description = "Show summary metrics"
  type        = bool
  default     = null
}

variable "slug" {
  description = "URL slug for the status page"
  type        = string
  default     = null
}

variable "theme" {
  description = "Status page theme"
  type        = string
  default     = null
}

variable "timezone" {
  description = "Timezone"
  type        = string
  default     = null
}

variable "uptime_calculation_type" {
  description = "Uptime calculation type"
  type        = string
  default     = null
}

variable "visibility_level" {
  description = "Status page visibility level"
  type        = string
  default     = null
}

################
# Sub-resources
################
variable "components" {
  description = "Status page components"
  type        = any
  default     = {}



  # Rejects attributes the module does not read; see allowlists.tf.
  validation {
    condition = alltrue([
      for k, v in var.components : length(setsubtract(try(keys(v), []), local.allowed_attributes.components)) == 0
    ])
    error_message = format(
      "var.components has unsupported attribute(s): %s. Valid attributes: %s.",
      join(", ", flatten([
        for k, v in var.components : [
          for a in setsubtract(try(keys(v), []), local.allowed_attributes.components) : format("%s.%s", k, a)
        ]
      ])),
      join(", ", local.allowed_attributes.components)
    )
  }
}

variable "incidents" {
  description = "Status page incidents"
  type        = any
  default     = {}



  # Rejects attributes the module does not read; see allowlists.tf.
  validation {
    condition = alltrue([
      for k, v in var.incidents : length(setsubtract(try(keys(v), []), local.allowed_attributes.incidents)) == 0
    ])
    error_message = format(
      "var.incidents has unsupported attribute(s): %s. Valid attributes: %s.",
      join(", ", flatten([
        for k, v in var.incidents : [
          for a in setsubtract(try(keys(v), []), local.allowed_attributes.incidents) : format("%s.%s", k, a)
        ]
      ])),
      join(", ", local.allowed_attributes.incidents)
    )
  }
}

variable "metrics" {
  description = "Status page metrics"
  type        = any
  default     = {}



  # Rejects attributes the module does not read; see allowlists.tf.
  validation {
    condition = alltrue([
      for k, v in var.metrics : length(setsubtract(try(keys(v), []), local.allowed_attributes.metrics)) == 0
    ])
    error_message = format(
      "var.metrics has unsupported attribute(s): %s. Valid attributes: %s.",
      join(", ", flatten([
        for k, v in var.metrics : [
          for a in setsubtract(try(keys(v), []), local.allowed_attributes.metrics) : format("%s.%s", k, a)
        ]
      ])),
      join(", ", local.allowed_attributes.metrics)
    )
  }
}

variable "subscribers" {
  description = "Status page subscribers"
  type        = any
  default     = {}



  # Rejects attributes the module does not read; see allowlists.tf.
  validation {
    condition = alltrue([
      for k, v in var.subscribers : length(setsubtract(try(keys(v), []), local.allowed_attributes.subscribers)) == 0
    ])
    error_message = format(
      "var.subscribers has unsupported attribute(s): %s. Valid attributes: %s.",
      join(", ", flatten([
        for k, v in var.subscribers : [
          for a in setsubtract(try(keys(v), []), local.allowed_attributes.subscribers) : format("%s.%s", k, a)
        ]
      ])),
      join(", ", local.allowed_attributes.subscribers)
    )
  }
}

variable "subscription_domain_allows" {
  description = "Allowed subscription domains"
  type        = any
  default     = {}



  # Rejects attributes the module does not read; see allowlists.tf.
  validation {
    condition = alltrue([
      for k, v in var.subscription_domain_allows : length(setsubtract(try(keys(v), []), local.allowed_attributes.subscription_domain_allows)) == 0
    ])
    error_message = format(
      "var.subscription_domain_allows has unsupported attribute(s): %s. Valid attributes: %s.",
      join(", ", flatten([
        for k, v in var.subscription_domain_allows : [
          for a in setsubtract(try(keys(v), []), local.allowed_attributes.subscription_domain_allows) : format("%s.%s", k, a)
        ]
      ])),
      join(", ", local.allowed_attributes.subscription_domain_allows)
    )
  }
}

variable "subscription_domain_blocks" {
  description = "Blocked subscription domains"
  type        = any
  default     = {}



  # Rejects attributes the module does not read; see allowlists.tf.
  validation {
    condition = alltrue([
      for k, v in var.subscription_domain_blocks : length(setsubtract(try(keys(v), []), local.allowed_attributes.subscription_domain_blocks)) == 0
    ])
    error_message = format(
      "var.subscription_domain_blocks has unsupported attribute(s): %s. Valid attributes: %s.",
      join(", ", flatten([
        for k, v in var.subscription_domain_blocks : [
          for a in setsubtract(try(keys(v), []), local.allowed_attributes.subscription_domain_blocks) : format("%s.%s", k, a)
        ]
      ])),
      join(", ", local.allowed_attributes.subscription_domain_blocks)
    )
  }
}

variable "users" {
  description = "Status page users"
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
