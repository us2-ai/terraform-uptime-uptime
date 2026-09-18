######################
# Uptime Integration #
######################
variable "create" {
  description = "Create"
  type        = bool
  default     = true
}

variable "type" {
  description = "The type of integration to create"
  type        = string

  validation {
    condition     = can(regex("^(cachet|datadog|geckoboard|jira_servicedesk|klipfolio|microsoft_teams|opsgenie|pagerduty|pushbullet|pushover|slack|status|statuspage|victorops|wavefront|webhook|zapier)$", var.type))
    error_message = "Must be a valid type of integration"
  }
}

variable "name" {
  description = "Name"
  type        = string
}

variable "contact_groups" {
  description = "Contact Groups"
  type        = list(string)
  default     = []
}

variable "settings" {
  description = "Integration-specific settings"
  type        = any
  default     = {}

  # Rejects attributes the module does not read; see allowlists.tf.
  validation {
    condition = length(setsubtract(try(keys(var.settings), []), local.allowed_attributes.settings)) == 0
    error_message = format(
      "var.settings has unsupported attribute(s): %s. Valid attributes (union across all integration types): %s.",
      join(", ", setsubtract(try(keys(var.settings), []), local.allowed_attributes.settings)),
      join(", ", local.allowed_attributes.settings)
    )
  }
}
