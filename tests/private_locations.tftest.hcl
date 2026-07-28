# Private monitoring locations.
#
# The lookup is deliberately lazy: reading the data source costs an API call, so it only happens
# when a check opts in or the caller asks for the outputs directly.
#
# Note: Terraform's provider mocking cannot populate the length of a nested-attribute list, so
# `data.uptime_private_locations.this[0].locations` is always empty under test. These tests cover
# whether the lookup happens and that an empty result degrades safely; the mapping from the
# `location` field is asserted in modules/check where the resource is directly addressable.

mock_provider "uptime" {}

variables {
  name    = "private-locations"
  address = "example.com"
}

run "lookup_is_skipped_when_nothing_consumes_it" {
  command = plan

  variables {
    checks = { homepage = { type = "http" } }
  }

  assert {
    condition     = length(data.uptime_private_locations.this) == 0
    error_message = "the data source should not be read when no check opts in"
  }
}

run "lookup_happens_when_a_check_opts_in" {
  command = plan

  variables {
    checks = { internal = { type = "http", use_private_locations = true } }
  }

  assert {
    condition     = length(data.uptime_private_locations.this) == 1
    error_message = "a check opting in should trigger the lookup"
  }
}

run "lookup_happens_when_requested_explicitly" {
  command = plan

  variables {
    lookup_private_locations = true
    checks                   = { homepage = { type = "http" } }
  }

  assert {
    condition     = length(data.uptime_private_locations.this) == 1
    error_message = "lookup_private_locations should trigger the lookup on its own"
  }
}

run "only_one_lookup_for_many_opted_in_checks" {
  command = plan

  variables {
    lookup_private_locations = true
    checks = {
      a = { type = "http", use_private_locations = true }
      b = { type = "http", use_private_locations = true }
      c = { type = "http" }
    }
  }

  assert {
    condition     = length(data.uptime_private_locations.this) == 1
    error_message = "the data source should be read once regardless of how many checks opt in"
  }
}

run "an_account_with_no_private_locations_still_applies" {
  command = apply

  variables {
    lookup_private_locations = true
    checks                   = { internal = { type = "http", use_private_locations = true } }
  }

  assert {
    condition     = output.private_check_locations == []
    error_message = "expected an empty list, got ${jsonencode(output.private_check_locations)}"
  }

  assert {
    condition     = output.check["internal"].id != null
    error_message = "a check opting in should still be created when the account has none"
  }
}
