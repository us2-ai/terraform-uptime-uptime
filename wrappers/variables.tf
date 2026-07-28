variable "defaults" {
  description = "Map of default values which will be used for each item."
  type        = any
  default     = {}



  # Rejects attributes the module does not read; see allowlists.tf.
  validation {
    condition = length(setsubtract(try(keys(var.defaults), []), local.allowed_attributes.defaults)) == 0
    error_message = format(
      "var.defaults has unsupported attribute(s): %s. Valid attributes: %s.",
      join(", ", setsubtract(try(keys(var.defaults), []), local.allowed_attributes.defaults)),
      join(", ", local.allowed_attributes.defaults)
    )
  }
}

variable "items" {
  description = "Maps of items to create a wrapper from. Values are passed through to the module."
  type        = any
  default     = {}



  # Rejects attributes the module does not read; see allowlists.tf.
  validation {
    condition = alltrue([
      for k, v in var.items : length(setsubtract(try(keys(v), []), local.allowed_attributes.items)) == 0
    ])
    error_message = format(
      "var.items has unsupported attribute(s): %s. Valid attributes: %s.",
      join(", ", flatten([
        for k, v in var.items : [
          for a in setsubtract(try(keys(v), []), local.allowed_attributes.items) : format("%s.%s", k, a)
        ]
      ])),
      join(", ", local.allowed_attributes.items)
    )
  }
}
