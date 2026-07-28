module "uptime" {
  source = "../../"

  name           = "private-locations-example"
  address        = "example.com"
  contact_groups = ["DevOps"]

  # Expose the private_locations / private_check_locations outputs even though
  # the checks below already trigger the lookup on their own.
  lookup_private_locations = true

  checks = {
    # Monitor an internal endpoint from every private location on the account.
    internal-api = {
      type                  = "http"
      address               = "https://api.internal.example.com"
      use_private_locations = true
    }

    # Private locations can be combined with public ones; the lists are merged
    # and de-duplicated.
    hybrid = {
      type                  = "http"
      address               = "https://www.example.com"
      locations             = ["US East"]
      use_private_locations = true
    }

    # Left alone, a check keeps using whatever public locations it was given.
    public-only = {
      type      = "http"
      locations = ["US East", "London"]
    }
  }
}
