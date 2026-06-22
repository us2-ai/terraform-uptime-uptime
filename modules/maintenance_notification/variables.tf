###################################
# Uptime Maintenance Notification #
###################################
variable "create" {
  description = "Create"
  type        = bool
  default     = true
}

variable "schedule_id" {
  description = "The ID of the maintenance schedule this notification belongs to"
  type        = number
}

variable "event" {
  description = "Event type the notification fires on (START or END)"
  type        = string
}

variable "offset" {
  description = "Offset in seconds relative to the event; negative means before the event"
  type        = number
}

variable "contact_groups" {
  description = "Contact group IDs to notify"
  type        = list(number)
}
