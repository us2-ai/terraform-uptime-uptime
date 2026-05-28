# Demonstrates referencing private monitoring locations registered in the
# Uptime.com account. Requires the us2-ai fork of the provider; see
# versions.tf at the module root for the pinned version and install
# instructions.

data "uptime_private_locations" "all" {}

locals {
  private_location_names = [
    for loc in data.uptime_private_locations.all.locations : loc.location
  ]
}

module "uptime" {
  source = "../../"

  name           = "internal-services"
  address        = "api.internal.example.com"
  contact_groups = ["Default"]

  checks = {
    internal_api = {
      type      = "http"
      locations = local.private_location_names
    }
  }
}

output "private_locations" {
  description = "Private monitoring locations registered in the account."
  value       = data.uptime_private_locations.all.locations
}
