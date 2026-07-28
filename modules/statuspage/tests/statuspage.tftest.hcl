# Status page wiring, including the INSPIRE-theme branding added for provider 2.30.0.
#
# All API-managed status pages render with the INSPIRE theme, so the legacy branding attributes
# have no visible effect on them and the `_inspire` variants are the ones that matter.

mock_provider "uptime" {}

variables {
  name = "Status"
}

run "inspire_branding_reaches_the_resource" {
  command = apply

  variables {
    custom_css_inspire         = ".banner { font-weight: 600; }"
    custom_header_html_inspire = "<div>Example</div>"
    custom_footer_html_inspire = "<footer>Example</footer>"
  }

  assert {
    condition     = uptime_statuspage.this[0].custom_css_inspire == ".banner { font-weight: 600; }"
    error_message = "custom_css_inspire was not passed through"
  }

  assert {
    condition     = uptime_statuspage.this[0].custom_header_html_inspire == "<div>Example</div>"
    error_message = "custom_header_html_inspire was not passed through"
  }

  assert {
    condition     = uptime_statuspage.this[0].custom_footer_html_inspire == "<footer>Example</footer>"
    error_message = "custom_footer_html_inspire was not passed through"
  }
}

run "other_attributes_added_for_2_31_reach_the_resource" {
  command = apply

  variables {
    allow_subscriptions_webhook = true
    visibility_level            = "PUBLIC"
  }

  assert {
    condition     = uptime_statuspage.this[0].allow_subscriptions_webhook == true
    error_message = "allow_subscriptions_webhook was not passed through"
  }

  assert {
    condition     = uptime_statuspage.this[0].visibility_level == "PUBLIC"
    error_message = "visibility_level was not passed through"
  }
}

run "allow_subscriptions_is_rejected" {
  command = plan

  # The API derives this from the per-channel flags and the provider stopped sending it in
  # 2.25.0, so a value here was silently discarded rather than applied.
  variables {
    allow_subscriptions = true
  }

  expect_failures = [var.allow_subscriptions]
}

run "per_channel_subscription_flags_are_accepted" {
  command = apply

  variables {
    allow_subscriptions_email = true
    allow_subscriptions_rss   = true
  }

  assert {
    condition     = uptime_statuspage.this[0].allow_subscriptions_email == true
    error_message = "allow_subscriptions_email was not passed through"
  }
}

run "component_sorting_weight_reaches_the_resource" {
  command = apply

  variables {
    components = {
      web = { name = "Web", sorting_weight = 10 }
      api = { name = "API", sorting_weight = 20 }
    }
  }

  assert {
    condition     = uptime_statuspage_component.this["web"].sorting_weight == 10
    error_message = "sorting_weight was not passed through"
  }

  assert {
    condition     = uptime_statuspage_component.this["api"].sorting_weight == 20
    error_message = "sorting_weight was not passed through for the second component"
  }
}

run "a_component_name_defaults_to_its_map_key" {
  command = apply

  variables {
    components = { checkout = {} }
  }

  assert {
    condition     = uptime_statuspage_component.this["checkout"].name == "checkout"
    error_message = "expected the map key as the default name"
  }
}

run "rejects_an_unknown_component_attribute" {
  command = plan

  variables {
    components = { web = { name = "Web", sorting_wieght = 1 } }
  }

  expect_failures = [var.components]
}

run "rejects_an_unknown_incident_attribute" {
  command = plan

  variables {
    incidents = { outage = { starts_at = "2026-01-01T00:00:00Z", ends = "2026-01-01T01:00:00Z" } }
  }

  expect_failures = [var.incidents]
}

run "rejects_an_unknown_subscriber_attribute" {
  command = plan

  variables {
    subscribers = { a = { type = "EMAIL", targett = "a@example.com" } }
  }

  expect_failures = [var.subscribers]
}

run "create_false_creates_nothing" {
  command = apply

  variables {
    create     = false
    components = { web = { name = "Web" } }
  }

  assert {
    condition     = length(uptime_statuspage.this) == 0
    error_message = "create = false should create no status page"
  }

  assert {
    condition     = length(uptime_statuspage_component.this) == 0
    error_message = "create = false should create no components either"
  }

  assert {
    condition     = output.id == null
    error_message = "id should be null when nothing was created"
  }
}
