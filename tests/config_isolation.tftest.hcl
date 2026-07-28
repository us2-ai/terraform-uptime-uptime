# The root `config` variable configures the primary check group only.
#
# It used to double as the default for each check's `config` block, but the two schemas do not
# overlap: a group's config is down_condition / response_time / services / tags /
# uptime_percent_calculation, while a check's config is the sslcert options. Feeding one to the
# other could never produce a meaningful value, and once the attribute allowlists landed it made
# any configuration that set `config` alongside a check fail to plan.

mock_provider "uptime" {}

variables {
  name    = "config-isolation"
  address = "example.com"
}

run "group_config_does_not_leak_into_checks" {
  command = plan

  variables {
    config = {
      down_condition             = "ANY"
      uptime_percent_calculation = "UP_DOWN_STATES"
    }
    checks = { homepage = { type = "http" } }
  }
}

run "group_config_coexists_with_an_sslcert_check" {
  command = apply

  variables {
    config = { down_condition = "ANY" }
    checks = {
      certs = { type = "sslcert", config = { issuer = "Example CA", self_signed = false } }
    }
  }

  assert {
    condition     = output.check["certs"].id != null
    error_message = "an sslcert check should be created alongside a group config"
  }
}
