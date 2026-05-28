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
  description = "Allow subscriptions"
  type        = bool
  default     = null
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
  description = "Custom CSS"
  type        = string
  default     = null
}

variable "custom_footer_html" {
  description = "Custom footer HTML"
  type        = string
  default     = null
}

variable "custom_header_bg_color_hex" {
  description = "Custom header background color hex"
  type        = string
  default     = null
}

variable "custom_header_html" {
  description = "Custom header HTML"
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

################
# Sub-resources
################
variable "components" {
  description = "Status page components"
  type        = any
  default     = {}
}

variable "incidents" {
  description = "Status page incidents"
  type        = any
  default     = {}
}

variable "metrics" {
  description = "Status page metrics"
  type        = any
  default     = {}
}

variable "subscribers" {
  description = "Status page subscribers"
  type        = any
  default     = {}
}

variable "subscription_domain_allows" {
  description = "Allowed subscription domains"
  type        = any
  default     = {}
}

variable "subscription_domain_blocks" {
  description = "Blocked subscription domains"
  type        = any
  default     = {}
}

variable "users" {
  description = "Status page users"
  type        = any
  default     = {}
}

# Inspire theme customization and layout. Requires the us2-ai provider fork;
# see the module-level versions.tf for the pinned provider release.

variable "custom_header_html_inspire" {
  description = "Custom header HTML applied only to the Inspire theme"
  type        = string
  default     = null
}

variable "custom_footer_html_inspire" {
  description = "Custom footer HTML applied only to the Inspire theme"
  type        = string
  default     = null
}

variable "custom_css_inspire" {
  description = "Custom CSS applied only to the Inspire theme"
  type        = string
  default     = null
}

variable "layout_preset" {
  description = "Inspire-theme layout preset (typically EXPANDED or COMPACT)"
  type        = string
  default     = null
}

variable "show_component_bars" {
  description = "Show component bars on the Inspire layout"
  type        = bool
  default     = null
}

variable "show_component_group_descriptions" {
  description = "Show component group descriptions on the Inspire layout"
  type        = bool
  default     = null
}

# Previously-unmapped general-purpose statuspage settings.

variable "allow_notifications" {
  description = "Allow subscriber notifications"
  type        = bool
  default     = null
}

variable "default_status_date_range" {
  description = "Default date range (days) shown on the status tab"
  type        = number
  default     = null
}

variable "hide_empty_tabs_status" {
  description = "Hide the status tab when no components are present"
  type        = bool
  default     = null
}

variable "logo_url" {
  description = "URL of the logo shown on the status page"
  type        = string
  default     = null
}

variable "email_logo_url" {
  description = "URL of the logo used in subscriber notification emails"
  type        = string
  default     = null
}

variable "favicon_url" {
  description = "URL of the favicon for the status page"
  type        = string
  default     = null
}
