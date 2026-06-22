##############
# Uptime Tag #
##############
variable "create" {
  description = "Create"
  type        = bool
  default     = true
}

variable "tag" {
  description = "Tag"
  type        = string
}

variable "color_hex" {
  description = "Tag color as a hex code (e.g. \"#cccccc\"). Required by the provider; defaults to \"#cccccc\" when unset."
  type        = string
  default     = null
}
