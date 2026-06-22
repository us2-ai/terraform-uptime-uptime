module "uptime" {
  source = "../../"

  name           = "maintenance-example"
  address        = "example.com"
  contact_groups = ["DevOps"]
  encryption     = true

  # Contacts whose IDs are referenced by maintenance notifications below.
  contacts = {
    oncall = {
      email_list = ["oncall@example.com"]
    }
  }

  checks = {
    homepage = {
      type = "http"
    }
    # Monitor every service in a public cloud provider's status group.
    aws-status = {
      type = "cloudstatus"
      cloudstatus_config = {
        group           = 12
        monitoring_type = "ALL"
      }
    }
  }

  # Account-level maintenance windows (recurring and one-off).
  maintenance_schedules = {
    # Recurring weekly patching window driven by an RRULE.
    weekly-patching = {
      schedule_type                   = "RRULE"
      starts_at                       = "2026-07-01T02:00:00Z"
      rrule                           = "FREQ=WEEKLY;BYDAY=SA"
      duration_minutes                = 120
      pause_checks_during_maintenance = true
      services                        = [module.uptime.check["homepage"].id]
    }
    # One-off database migration window bounded by a fixed end time.
    db-migration = {
      schedule_type = "ONE_OFF"
      starts_at     = "2026-07-15T22:00:00Z"
      ends_at       = "2026-07-16T02:00:00Z"
      services      = [module.uptime.check["homepage"].id]
    }
  }

  # Notify on-call around the recurring patching window.
  maintenance_notifications = {
    patching-start = {
      schedule_id    = module.uptime.maintenance_schedule["weekly-patching"].id
      event          = "START"
      offset         = -1800 # 30 minutes before the window starts
      contact_groups = [module.uptime.contact["oncall"].id]
    }
    patching-end = {
      schedule_id    = module.uptime.maintenance_schedule["weekly-patching"].id
      event          = "END"
      offset         = 0
      contact_groups = [module.uptime.contact["oncall"].id]
    }
  }
}
