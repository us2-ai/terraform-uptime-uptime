resource "uptime_maintenance_notification" "this" {
  count = var.create ? 1 : 0

  schedule_id    = var.schedule_id
  event          = var.event
  offset         = var.offset
  contact_groups = var.contact_groups
}
