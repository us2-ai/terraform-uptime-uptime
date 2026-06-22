###############################
# Uptime Maintenance Schedule #
###############################
variable "create" {
  description = "Create"
  type        = bool
  default     = true
}

variable "name" {
  description = "Maintenance schedule name"
  type        = string
}

variable "schedule_type" {
  description = "Recurrence type. RRULE requires rrule and duration_minutes; ONE_OFF requires duration_minutes or ends_at"
  type        = string
}

variable "starts_at" {
  description = "Start time in RFC 3339 format"
  type        = string
}

variable "duration_minutes" {
  description = "Maintenance window length in minutes"
  type        = number
  default     = null
}

variable "ends_at" {
  description = "End time in RFC 3339 format"
  type        = string
  default     = null
}

variable "is_active" {
  description = "Whether the maintenance schedule is active"
  type        = bool
  default     = null
}

variable "pause_checks_during_maintenance" {
  description = "Pause checks during the maintenance window"
  type        = bool
  default     = null
}

variable "rrule" {
  description = "RFC 5545 recurrence rule (e.g. FREQ=WEEKLY;BYDAY=SA)"
  type        = string
  default     = null
}

variable "services" {
  description = "Service (check) IDs covered by the maintenance window"
  type        = list(number)
  default     = null
}

variable "tags" {
  description = "Service tag IDs covered by the maintenance window"
  type        = list(number)
  default     = null
}
