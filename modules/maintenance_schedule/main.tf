resource "uptime_maintenance_schedule" "this" {
  count = var.create ? 1 : 0

  name          = var.name
  schedule_type = var.schedule_type
  starts_at     = var.starts_at

  duration_minutes                = var.duration_minutes
  ends_at                         = var.ends_at
  is_active                       = var.is_active
  pause_checks_during_maintenance = var.pause_checks_during_maintenance
  rrule                           = var.rrule
  services                        = var.services
  tags                            = var.tags
}
