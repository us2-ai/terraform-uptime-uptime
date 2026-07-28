# Regression tests for the per-item `create_*` flags.
#
# Before v2.0.0 the check and integration `id`/`name` outputs were built with coalesce() over
# every possible resource type. coalesce() fails when all its arguments are null, which is
# exactly what a disabled resource produces, so setting create_check = false or
# create_integration = false made `terraform plan` fail outright.

mock_provider "uptime" {}

variables {
  name    = "disabled"
  address = "example.com"
}

run "a_disabled_check_plans_and_reports_null" {
  command = apply

  variables {
    checks = {
      on  = { type = "http" }
      off = { type = "http", create_check = false }
    }
  }

  assert {
    condition     = output.check["off"].id == null
    error_message = "a disabled check should report a null id, got ${jsonencode(output.check["off"].id)}"
  }

  assert {
    condition     = output.check["off"].name == null
    error_message = "a disabled check should report a null name, got ${jsonencode(output.check["off"].name)}"
  }

  assert {
    condition     = output.check["on"].id != null
    error_message = "an enabled check should still report an id"
  }
}

run "a_disabled_integration_plans_and_reports_null" {
  command = apply

  variables {
    integrations = {
      off = {
        type               = "slack"
        create_integration = false
        settings           = { webhook_url = "https://example.com/hook" }
      }
    }
  }

  assert {
    condition     = output.integration["off"].id == null
    error_message = "a disabled integration should report a null id, got ${jsonencode(output.integration["off"].id)}"
  }
}

run "disabling_every_optional_resource_still_plans" {
  command = apply

  variables {
    create_tag   = false
    create_group = false

    checks       = { off = { type = "http", create_check = false } }
    integrations = { off = { type = "slack", create_integration = false, settings = {} } }
    statuspages  = { off = { name = "Off", create_statuspage = false } }
    users        = { off = { email = "a@example.com", password = "x", first_name = "A", last_name = "B", create_user = false } }
  }

  assert {
    condition     = output.tag == {}
    error_message = "no tag module instances were expected"
  }
}

run "create_false_produces_no_resources_at_all" {
  command = apply

  variables {
    create = false
    checks = { homepage = { type = "http" } }
  }

  assert {
    condition     = output.check == {}
    error_message = "create = false should produce no check instances"
  }

  assert {
    condition     = length(data.uptime_private_locations.this) == 0
    error_message = "create = false should not read the private locations data source"
  }
}
