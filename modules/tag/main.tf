resource "uptime_tag" "this" {
  count = var.create ? 1 : 0

  tag = var.tag
  # color_hex is required by the provider as of uptime-com/uptime v2.20.
  # Fall back to a neutral default when the caller does not supply one so
  # tag creation does not fail on a missing required attribute.
  color_hex = coalesce(var.color_hex, "#cccccc")
}
