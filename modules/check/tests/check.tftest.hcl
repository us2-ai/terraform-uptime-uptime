# The check module dispatches to one of 22 provider resources based on var.type.
#
# These tests run against the submodule directly, so the resources are addressable and the
# wiring can be asserted rather than inferred.

mock_provider "uptime" {}

variables {
  name = "check"
}

run "type_selects_exactly_one_resource" {
  command = apply

  variables {
    type    = "http"
    address = "example.com"
  }

  assert {
    condition     = length(uptime_check_http.this) == 1
    error_message = "an http check should create the http resource"
  }

  assert {
    condition     = length(uptime_check_dns.this) == 0 && length(uptime_check_sslcert.this) == 0
    error_message = "no other check resource should be created"
  }

  assert {
    condition     = output.id != null
    error_message = "id should be populated for a created check"
  }
}

run "an_unsupported_type_is_rejected" {
  command = plan

  variables {
    type = "gopher"
  }

  expect_failures = [var.type]
}

run "create_false_creates_nothing_and_reports_null" {
  command = apply

  variables {
    create  = false
    type    = "http"
    address = "example.com"
  }

  assert {
    condition     = length(uptime_check_http.this) == 0
    error_message = "create = false should create no resource"
  }

  # Regression: these outputs used coalesce(), which fails when every argument is null.
  assert {
    condition     = output.id == null && output.name == null
    error_message = "outputs should be null, not an error, when the check is not created"
  }
}

run "locations_reach_the_resource" {
  command = apply

  variables {
    type      = "http"
    address   = "example.com"
    locations = ["US East", "dc1"]
  }

  assert {
    condition     = uptime_check_http.this[0].locations == toset(["US East", "dc1"])
    error_message = "locations were not passed through: ${jsonencode(uptime_check_http.this[0].locations)}"
  }
}

run "sslcert_config_reaches_the_resource" {
  command = apply

  variables {
    type    = "sslcert"
    address = "example.com"
    config  = { issuer = "Example CA", self_signed = false, min_version = "tlsv12" }
  }

  assert {
    condition     = uptime_check_sslcert.this[0].config.issuer == "Example CA"
    error_message = "sslcert config was not passed through"
  }
}

run "rejects_an_unknown_sslcert_config_attribute" {
  command = plan

  variables {
    type    = "sslcert"
    address = "example.com"
    # down_condition belongs to a check group's config, not a check's.
    config = { down_condition = "ANY" }
  }

  expect_failures = [var.config]
}

run "rejects_an_unknown_pagespeed_config_attribute" {
  command = plan

  variables {
    type             = "pagespeed"
    address          = "example.com"
    pagespeed_config = { emulated_devices = "mobile" }
  }

  expect_failures = [var.pagespeed_config]
}

run "rejects_an_unknown_cloudstatus_config_attribute" {
  command = plan

  variables {
    type               = "cloudstatus"
    cloudstatus_config = { monitoring_typ = "ALL" }
  }

  expect_failures = [var.cloudstatus_config]
}

run "heartbeat_url_is_only_set_for_heartbeat_checks" {
  command = apply

  variables {
    type = "heartbeat"
  }

  assert {
    condition     = output.heartbeat_url != null
    error_message = "a heartbeat check should expose a heartbeat_url"
  }

  assert {
    condition     = output.webhook_url == null
    error_message = "a heartbeat check should not expose a webhook_url"
  }
}

run "an_address_less_check_type_does_not_need_an_address" {
  command = apply

  # Regression: local.http_address used join(), which rejects a null address, so a heartbeat
  # check with no address failed to plan even though the type never uses one.
  variables {
    type = "heartbeat"
  }

  assert {
    condition     = length(uptime_check_heartbeat.this) == 1
    error_message = "a heartbeat check should not require an address"
  }
}

run "use_ip_version_reaches_the_http_resource" {
  command = apply

  # Regression: provider 2.34.0 added use_ip_version to uptime_check_http and uptime_check_api.
  # Before that the module could not set it on either type, so a caller's value was dropped.
  variables {
    type           = "http"
    address        = "example.com"
    use_ip_version = "IPV6"
  }

  assert {
    condition     = uptime_check_http.this[0].use_ip_version == "IPV6"
    error_message = "use_ip_version was not passed through to the http resource"
  }
}

run "use_ip_version_reaches_the_api_resource" {
  command = apply

  variables {
    type           = "api"
    script         = "[]"
    use_ip_version = "IPV4"
  }

  assert {
    condition     = uptime_check_api.this[0].use_ip_version == "IPV4"
    error_message = "use_ip_version was not passed through to the api resource"
  }
}
