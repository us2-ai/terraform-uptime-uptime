# The wrapper re-implements every root module argument with a three-level try() fallback
# (item -> defaults -> literal). That makes it a second place an unrecognised attribute could be
# dropped silently, so it carries the same allowlists as the root module.

mock_provider "uptime" {}

run "an_item_plans" {
  command = plan

  variables {
    items = {
      one = {
        name    = "one"
        address = "example.com"
        checks  = { homepage = { type = "http" } }
      }
    }
  }
}

run "defaults_apply_to_items_that_omit_a_value" {
  command = apply

  variables {
    defaults = {
      address        = "shared.example.com"
      contact_groups = ["DevOps"]
    }
    items = {
      one = { name = "one", checks = { homepage = { type = "http" } } }
      two = { name = "two", address = "specific.example.com" }
    }
  }

  assert {
    condition     = module.wrapper["one"].check["homepage"].id != null
    error_message = "an item relying on defaults should still create its check"
  }
}

run "rejects_an_unknown_item_attribute" {
  command = plan

  variables {
    items = { one = { name = "one", chekcs = {} } }
  }

  expect_failures = [var.items]
}

run "rejects_an_unknown_defaults_attribute" {
  command = plan

  variables {
    defaults = { addres = "example.com" }
    items    = { one = { name = "one" } }
  }

  expect_failures = [var.defaults]
}

run "no_items_produces_nothing" {
  command = apply

  assert {
    condition     = module.wrapper == {}
    error_message = "an empty items map should produce no wrapper instances"
  }
}
