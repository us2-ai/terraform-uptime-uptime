module "uptime" {
  source = "../../"

  name           = "complete-example"
  address        = "example.com"
  contact_groups = ["DevOps"]
  encryption     = true
  interval       = 5
  num_retries    = 2

  tags = {
    staging = {
      color_hex = "#FFA500"
    }
  }

  groups = {
    secondary = {
      contact_groups = ["DevOps"]
      config = {
        down_condition             = "ANY"
        uptime_percent_calculation = "AVERAGE"
      }
    }
  }

  checks = {
    homepage = {
      type        = "http"
      status_code = "200"
      threshold   = 30
    }
    dns = {
      type            = "dns"
      dns_record_type = "A"
      expect_string   = "93.184.216.34"
    }
    heartbeat = {
      type = "heartbeat"
    }
    ping = {
      type = "icmp"
    }
    ssl = {
      type = "sslcert"
      config = {
        min_version = "TLSv1.2"
      }
      threshold = 30
    }
    api = {
      type   = "api"
      script = jsonencode([{ step_def = "C_URL", values = { url = "https://example.com/api/health" } }])
    }
    cloud = {
      type = "cloudstatus"
      cloudstatus_config = {
        group           = 12
        monitoring_type = "ALL"
      }
    }
  }

  integrations = {
    slack = {
      type = "slack"
      settings = {
        webhook_url = "https://hooks.slack.com/services/T00/B00/xxx"
        channel     = "#monitoring"
      }
    }
    pagerduty = {
      type = "pagerduty"
      settings = {
        service_key  = "your-pagerduty-service-key"
        auto_resolve = true
      }
    }
  }

  escalations = {
    homepage = {
      check_id = module.uptime.check["homepage"].id
      escalations = [
        {
          contact_groups = ["DevOps"]
          num_repeats    = 3
          wait_time      = 5
        },
        {
          contact_groups = ["Management"]
          num_repeats    = 1
          wait_time      = 15
        }
      ]
    }
  }

  maintenances = {
    weekly = {
      check_id = module.uptime.check["homepage"].id
      state    = "ACTIVE"
      schedule = [
        {
          type      = "WEEKLY"
          weekdays  = ["SUN"]
          from_time = "02:00"
          to_time   = "04:00"
        }
      ]
    }
  }

  maintenance_schedules = {
    weekly-patching = {
      schedule_type                   = "RRULE"
      starts_at                       = "2026-07-01T02:00:00Z"
      rrule                           = "FREQ=WEEKLY;BYDAY=SA"
      duration_minutes                = 120
      pause_checks_during_maintenance = true
      services                        = [module.uptime.check["homepage"].id]
    }
  }

  maintenance_notifications = {
    notify-before-start = {
      schedule_id    = module.uptime.maintenance_schedule["weekly-patching"].id
      event          = "START"
      offset         = -1800 # 30 minutes before
      contact_groups = [module.uptime.contact["devops"].id]
    }
  }

  contacts = {
    devops = {
      email_list = ["oncall@example.com", "devops@example.com"]
      sms_list   = ["+15551234567"]
    }
    management = {
      email_list = ["cto@example.com"]
    }
  }

  statuspages = {
    public = {
      name                  = "Service Status"
      slug                  = "status"
      allow_subscriptions   = true
      show_active_incidents = true
      show_history_tab      = true
      timezone              = "UTC"

      components = {
        website = {
          name       = "Website"
          service_id = module.uptime.check["homepage"].id
        }
        dns = {
          name       = "DNS"
          service_id = module.uptime.check["dns"].id
        }
      }
    }
  }

  credentials = {
    api-token = {
      credential_type = "TOKEN"
      secret = {
        secret = "your-api-token"
      }
    }
  }

  sla_reports = {
    monthly = {
      show_uptime_section        = true
      show_uptime_sla            = true
      show_response_time_section = true
      services_tags              = ["complete-example"]
    }
  }

  scheduled_reports = {
    weekly-sla = {
      sla_report       = module.uptime.sla_report["monthly"].name
      recurrence       = "WEEKLY"
      on_weekday       = 1
      at_time          = 9
      file_type        = "PDF"
      recipient_emails = ["devops@example.com"]
    }
  }

  subaccounts = {
    staging = {}
  }
}
