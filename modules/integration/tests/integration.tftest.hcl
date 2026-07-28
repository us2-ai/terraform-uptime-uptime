# The integration module dispatches to one of 17 provider resources based on var.type.

mock_provider "uptime" {}

variables {
  name = "alerts"
}

run "type_selects_exactly_one_resource" {
  command = apply

  variables {
    type     = "slack"
    settings = { webhook_url = "https://example.com/hook", channel = "#alerts" }
  }

  assert {
    condition     = length(uptime_integration_slack.this) == 1
    error_message = "a slack integration should create the slack resource"
  }

  assert {
    condition     = length(uptime_integration_pagerduty.this) == 0
    error_message = "no other integration resource should be created"
  }
}

run "settings_reach_the_resource" {
  command = apply

  variables {
    type     = "slack"
    settings = { webhook_url = "https://example.com/hook", channel = "#alerts" }
  }

  assert {
    condition     = uptime_integration_slack.this[0].channel == "#alerts"
    error_message = "settings were not passed through"
  }
}

run "an_unsupported_type_is_rejected" {
  command = plan

  variables {
    type = "carrier-pigeon"
  }

  expect_failures = [var.type]
}

run "rejects_an_unknown_settings_attribute" {
  command = plan

  variables {
    type     = "slack"
    settings = { webhook_url = "https://example.com/hook", chanel = "#alerts" }
  }

  expect_failures = [var.settings]
}

run "settings_are_checked_against_the_union_not_per_type" {
  command = plan

  # A known limitation: the allowlist cannot reference the sibling `type` variable, so an
  # attribute valid for a different integration type is accepted here. This test documents
  # the limitation so a change in behaviour is noticed.
  variables {
    type     = "pagerduty"
    settings = { service_key = "abc", channel = "#not-a-pagerduty-field" }
  }
}

run "create_false_creates_nothing_and_reports_null" {
  command = apply

  variables {
    create   = false
    type     = "slack"
    settings = { webhook_url = "https://example.com/hook" }
  }

  assert {
    condition     = length(uptime_integration_slack.this) == 0
    error_message = "create = false should create no resource"
  }

  # Regression: these outputs used coalesce(), which fails when every argument is null.
  assert {
    condition     = output.id == null && output.name == null
    error_message = "outputs should be null, not an error, when the integration is not created"
  }
}
