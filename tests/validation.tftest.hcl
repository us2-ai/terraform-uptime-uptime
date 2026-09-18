# Attribute allowlists on the root module's collections.
#
# These variables are typed `any`, so without the allowlists an unrecognised attribute is
# discarded silently and the configuration applies as though it were correct.

mock_provider "uptime" {}

variables {
  name    = "validation"
  address = "example.com"
}

run "accepts_a_valid_configuration" {
  command = plan

  variables {
    checks = {
      homepage = { type = "http", interval = 5 }
      certs    = { type = "sslcert", config = { issuer = "Example CA" } }
    }
    integrations = {
      alerts = { type = "slack", settings = { webhook_url = "https://example.com/hook", channel = "#a" } }
    }
    statuspages = {
      public = {
        name                      = "Status"
        allow_subscriptions_email = true
        custom_css_inspire        = ".a{}"
        components                = { web = { name = "Web", sorting_weight = 10 } }
      }
    }
    tags  = { env = { color_hex = "#ffffff" } }
    users = { someone = { email = "someone@example.com", password = "correct-horse-battery", first_name = "A", last_name = "B" } }
  }
}

run "rejects_a_misspelled_check_attribute" {
  command = plan

  variables {
    # Singular; the real attribute is use_private_locations.
    checks = { homepage = { type = "http", use_private_location = true } }
  }

  expect_failures = [var.checks]
}

run "rejects_an_attribute_that_is_not_a_check_attribute_at_all" {
  command = plan

  variables {
    # sorting_weight belongs to a status page component.
    checks = { homepage = { type = "http", sorting_weight = 1 } }
  }

  expect_failures = [var.checks]
}

run "rejects_unknown_statuspage_attribute" {
  command = plan

  variables {
    statuspages = { public = { name = "Status", custom_css_inspir = ".a{}" } }
  }

  expect_failures = [var.statuspages]
}

run "rejects_unknown_integration_attribute" {
  command = plan

  variables {
    integrations = { alerts = { type = "slack", setings = {} } }
  }

  expect_failures = [var.integrations]
}

run "rejects_unknown_contact_attribute" {
  command = plan

  variables {
    contacts = { oncall = { email_lists = ["a@example.com"] } }
  }

  expect_failures = [var.contacts]
}

run "rejects_unknown_maintenance_schedule_attribute" {
  command = plan

  variables {
    maintenance_schedules = {
      window = { schedule_type = "ONE_OFF", starts_at = "2026-01-01T00:00:00Z", ends = "2026-01-01T01:00:00Z" }
    }
  }

  expect_failures = [var.maintenance_schedules]
}

run "rejects_a_group_attribute_the_module_never_read" {
  command = plan

  variables {
    # The group module reads additional_tags; `tags` was silently discarded before v2.0.0.
    groups = { web = { tags = ["a"] } }
  }

  expect_failures = [var.groups]
}

run "rejects_the_removed_maintenances_collection" {
  command = plan

  # Provider 3.0.0 removed uptime_check_maintenance. The variable is retained only so that a
  # configuration carried over from 2.x fails with the migration steps named, rather than with
  # an unexplained "Unsupported argument".
  variables {
    maintenances = { weekly = { check_id = 1, state = "ACTIVE" } }
  }

  expect_failures = [var.maintenances]
}
